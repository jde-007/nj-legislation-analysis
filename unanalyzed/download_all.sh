#!/bin/bash
# NJ Legislature Science-Relevant Hearings Downloader

BASE="https://pub.njleg.state.nj.us/publications/public-hearings"

download_pdf() {
    url="$1"
    name="$2"
    if [ ! -f "$name.pdf" ]; then
        echo "Downloading: $name"
        curl -s -o "$name.pdf" "$url"
        if [ -s "$name.pdf" ]; then
            echo "  ✓ Downloaded"
        else
            echo "  ✗ Failed or empty"
            rm -f "$name.pdf"
        fi
    else
        echo "  Already exists: $name.pdf"
    fi
}

echo "=== 2022 Climate Series ==="
download_pdf "$BASE/22/sen02102022.pdf" "2022-02-10-climate-ghg"
download_pdf "$BASE/22/sen03142022.pdf" "2022-03-14-net-zero-2050"
download_pdf "$BASE/22/sen04212022.pdf" "2022-04-21-climate-adaptation"
download_pdf "$BASE/22/sen05162022.pdf" "2022-05-16-food-waste-ghg"
download_pdf "$BASE/22/sen06092022.pdf" "2022-06-09-industry-climate"
download_pdf "$BASE/22/sen06132022.pdf" "2022-06-13-circular-economy"
download_pdf "$BASE/22/senaen08112022.pdf" "2022-08-11-coastal-resiliency"

echo ""
echo "=== 2020s Key Hearings ==="
download_pdf "$BASE/20/senath02032020.pdf" "2020-02-03-energy" # May not exist
download_pdf "$BASE/19/sen05022019.pdf" "2019-05-02-environment" # May not exist
download_pdf "$BASE/18/sen02222018.pdf" "2018-02-22-environment" # May not exist

echo ""
echo "=== Probing 2010s for environment hearings ==="
for year in 19 18 17 16 15 14 13 12 11 10; do
    # Try common environment committee hearing dates
    for month in "02" "03" "04" "05" "06" "09" "10" "11"; do
        for day in "01" "15"; do
            url="$BASE/$year/sen${month}${day}20${year}.pdf"
            code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 2 "$url" 2>/dev/null)
            if [ "$code" = "200" ]; then
                name="20${year}-${month}-${day}-environment"
                if [ ! -f "$name.pdf" ]; then
                    echo "FOUND: $url"
                    download_pdf "$url" "$name"
                fi
            fi
        done
    done
done

echo ""
echo "Done!"
