#!/usr/bin/env bash
# Downloads every original image from Squarespace's CDN and saves it into
# src/images/ under the filename the site templates already expect.
#
# Run this ONCE, from your own computer (needs your own internet connection),
# before you cancel your Squarespace plan — those URLs stop working the day
# your subscription ends.
#
# Usage:
#   cd locus-site
#   bash scripts/download-images.sh

set -e
mkdir -p src/images
cd src/images

declare -A IMAGES=(
  ["home-hero-1.jpg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/e83b8a67-cea8-4208-a740-3518f03b06d5/jakub-klucky-7yeqemd-p90-unsplash.jpg"
  ["home-hero-2.jpg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/1781019293604-AALFRNWWXJKHUUSTYA69/unsplash-image-bodma3C2GHE.jpg"
  ["home-hero-3.png"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/87684e50-02bb-41be-8787-fd4658186175/body-wide.png"
  ["home-massage-card.jpg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/e60ab121-02f1-4df4-97b9-625f110ecbf4/massage-a-domicile-3aGV2ViCzrM-unsplash.jpg"
  ["home-yoga-card.jpeg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/1780939574965-WK9FA3K47D4ZB263NC1U/image-asset.jpeg"
  ["home-about-1.jpg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/3e3a0b97-fb4e-4cd4-b504-7d626c2619c1/Screenshot+2023-09-06+at+4.22.50+PM.jpg"
  ["home-about-2.jpg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/e27d6785-1b9e-4bb1-bb0f-0c89b0142781/540453936_10172994292515724_6578737113895735345_n.jpg"
  ["home-about-3.jpg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/1677b020-1e0c-4081-a908-0f0e4bc9138f/PNG+image.jpg"
  ["massage-hero.jpg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/e3ecefa2-9854-4ab4-821a-9405e6bcedcb/karly-jones-4caRljJwGsE-unsplash.jpg"
  ["yoga-hero.jpeg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/1596152410250-NO1N8OSPQT88OJ9K3R5Q/image-asset.jpeg"
  ["blog-healing-consistent-yoga.jpeg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/1705612430976-P4PWFWH2VB090G0PRVQ3/image-asset.jpeg"
  ["blog-yoga-book-list.jpeg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/1718226118799-I3X8YZR5C62NMEUD3Z6N/image-asset.jpeg"
  ["blog-poem-spring.jpg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/1743099927946-5D63ZLYUWSV63BDOBKMT/unsplash-image-xHxLpgvb6BY.jpg"
  ["blog-guest-house.jpg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/1637260532096-ROV13LW61J6D0JYOAA6Y/unsplash-image-dViaab0Qc8o.jpg"
  ["blog-grief-poem.jpg"]="https://images.squarespace-cdn.com/content/v1/5f220c0c0bb8744b10440bb2/1637260189698-SWWSE3W67ACHLTG6T42C/unsplash-image-m8nRxnGFWVc.jpg"
)

for filename in "${!IMAGES[@]}"; do
  url="${IMAGES[$filename]}"
  echo "Downloading $filename ..."
  curl -sL -o "$filename" "$url"
done

echo ""
echo "Done. $(ls | wc -l) images saved into src/images/"
