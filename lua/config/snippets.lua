local function snip(lhs, body)
  vim.keymap.set("i", "<C-.>" .. lhs, function() vim.snippet.expand(body) end)
end

snip(".", '["${1}"]${0}')
snip("c", 'col("${1}")${0}')
snip("a", '.alias("${1}")${0}')
snip("w", ".with_columns(${1})${0}")
snip("d", "pl.date(${1}, ${2}, ${3})${0}")
snip("t", ".cut([${1}], include_breaks=True)${0}")
snip("s", [[import typer
import polars as pl
from pathlib import Path
from cyc import *

DF_TYPE = Path(__file__).stem.removeprefix("save_")


def main(
    date: str = "20260326",
    write: bool = False,
):
    ${1:df = pl.DataFrame()}

    if write:
        path = get_data_path(DF_TYPE) / f"{date}.parquet"
        path.parent.mkdir(parents=True, exist_ok=True)
        df.write_parquet(path)
    else:
        globals().update(locals())


if __name__ == "__main__":
    typer.run(main)
]])
