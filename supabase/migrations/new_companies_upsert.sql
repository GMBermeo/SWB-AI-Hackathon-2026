-- UPSERT companies from job listings CSV
-- Generated: 2026-05-22
-- 207 unique employers; ON CONFLICT (slug) preserves existing rows

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), '3pillar-global', '3Pillar Global', '3pillarglobal.com', 0, 'https://www.glassdoor.com/Overview/Working-at-3Pillar-Global-EI_IE405053.11,25.htm', 'United States', 'Fairfax', 'VA', 'Information Technology', 3.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'actionet', 'ActioNet, Inc.', 'actioner.com', 0, 'https://www.glassdoor.com/Overview/Working-at-ActioNet-EI_IE33132.11,19.htm', 'United States', 'Vienna', 'VA', 'Information Technology', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'ad-hoc', 'Ad Hoc Beheer', 'adhoc.team', 0, 'https://www.glassdoor.com/Overview/Working-at-Ad-Hoc-EI_IE1073763.11,17.htm', 'United States', 'Washington', 'DC', 'Information Technology', 3.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'affinity-solutions', 'Affinity Solutions, Inc.', 'affinitysolutions.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Affinity-Solutions-EI_IE20496.11,29.htm', 'United States', 'New York', 'NY', 'Media & Communication', 3.7, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'agile-defense', 'Agile Defense, Inc', 'agiledefense.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Agile-Defense-EI_IE526295.11,24.htm', 'United States', 'Chantilly', 'VA', 'Information Technology', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'hudl', 'Agile Sports Technologies, Inc.', 'hudl.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Hudl-EI_IE826705.11,15.htm', 'United States', 'Lincoln', 'NE', 'Information Technology', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'alteryx', 'Alteryx, LLC', 'alteryx.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Alteryx-EI_IE351220.11,18.htm', 'United States', 'Irvine', 'CA', 'Information Technology', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'anexinet', 'Anexinet Corp.', 'anexinet.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Anexinet-EI_IE157115.11,19.htm', 'United States', 'Center Square', 'PA', 'Information Technology', 3.7, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'assured', 'Assured Insurance Technologies, Inc.', 'assuredallied.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Assured-EI_IE4006668.11,18.htm', 'United States', 'Palo Alto', 'CA', 'Insurance Technology', 3.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'atomi-financial-group', 'Atomi Financial Group, Inc', 'atomifinancial.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Atomi-Financial-Group-EI_IE1441963.11,32.htm', 'United States', 'Milwaukee', 'WI', 'Financial Services', 1.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'auction-technology-group', 'Auction Technology Group', 'auctiontechnologygroup.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Auction-Technology-Group-EI_IE2071353.11,35.htm', 'United States', 'London', NULL, 'Information Technology', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'auria', 'Auria', 'auriasolutions.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Auria-EI_IE231267.11,16.htm', 'United States', 'Charlotte', 'NC', 'Aerospace & Defense', 4.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'autods', 'AutoDS Ltd', 'autods.com', 0, 'https://www.glassdoor.com/Overview/Working-at-AutoDS-EI_IE3140181.11,17.htm', 'United States', 'Tel Aviv', NULL, 'E-Commerce Automation', 4.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'ayr-wellness', 'Ayr Wellness Inc.', 'ayrwellness.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Ayr-Wellness-EI_IE4806427.11,23.htm', 'United States', 'Miami', 'FL', 'Personal Consumer Services', 2.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'bask-health', 'Bask Health, Inc', 'baskhealth.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Bask-Health-EI_IE8450196.11,22.htm', 'United States', 'New York', 'NY', 'Digital Health', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'bitpay', 'BitPay, Inc.', 'bitpay.com', 0, 'https://www.glassdoor.com/Overview/Working-at-BitPay-EI_IE949426.11,17.htm', 'United States', 'Atlanta', 'GA', 'Financial Services', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'block-labs', 'Block Labs ltd.', 'blocklabs.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Block-Labs-EI_IE10968047.11,21.htm', 'United States', 'Malta', 'MT', 'Blockchain Technology', 3.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'bloom-equity-partners', 'Bloom Equity Partners', 'bloomequity.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Bloom-Equity-Partners-EI_IE11119216.11,32.htm', 'United States', 'Dallas', 'TX', 'Private Equity', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'bloomerang', 'Bloomerang', 'bloomerang.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Bloomerang-EI_IE892748.11,21.htm', 'United States', 'Indianapolis', 'IN', 'Information Technology', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'bold-beyond', 'Bold+Beyond', 'boldandbeyond.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Bold-Beyond-EI_IE986147.11,22.htm', 'United States', 'Los Angeles', 'CA', 'Media & Communication', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'boompop', 'BoomPop, Inc', 'boompop.com', 0, 'https://www.glassdoor.com/Overview/Working-at-BoomPop-EI_IE9238690.11,18.htm', 'United States', 'San Francisco', 'CA', 'Arts, Entertainment & Recreation', 4.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'bright-vision-technologies', 'Bright Vision Technologies', 'brightvisiontechnologies.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Bright-Vision-Technologies-EI_IE10002581.11,37.htm', 'United States', 'Herndon', 'VA', 'Information Technology', 4.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'csc-generation', 'CSC Generation', 'cscgeneration.com', 0, 'https://www.glassdoor.com/Overview/Working-at-CSC-Generation-EI_IE2091791.11,25.htm', 'United States', 'Chicago', 'IL', 'Information Technology', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'cvs-health', 'CVS Caremark Corporation', 'cvshealth.com', 0, 'https://www.glassdoor.com/Overview/Working-at-CVS-Health-EI_IE437.11,21.htm', 'United States', 'Washington', 'DC', 'Healthcare', 3.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'cadex', 'Cadex Inc', 'cadex.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Cadex-EI_IE6500228.11,16.htm', 'United States', 'Melville', 'NY', 'Management & Consulting', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'calendly', 'Calendly', 'calendly.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Calendly-EI_IE1268317.11,19.htm', 'United States', 'Atlanta', 'GA', 'Information Technology', 2.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'calqulate', 'Calqulate', 'calqulate.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Calqulate-EI_IE5390380.11,20.htm', 'United States', 'San Francisco', 'CA', 'Financial Analytics Software', 4.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'cartkit', 'CartKit', 'cartkit.com', 0, 'https://www.glassdoor.com/Overview/Working-at-CartKit-EI_IE8682297.11,18.htm', 'United States', 'San Juan', 'PR', 'E-Commerce Technology', 3.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'caselle', 'Caselle', 'caselle.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Caselle-EI_IE623942.11,18.htm', 'United States', 'Provo', 'UT', 'Information Technology', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'central-point-partners', 'Central Point Partners, LLC', 'centralpointpartners.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Central-Point-Partners-EI_IE974669.11,33.htm', 'United States', 'Boston', 'MA', 'Information Technology', 4.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'certificate-hero', 'Certificate Hero Inc', 'certificatehero.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Certificate-Hero-EI_IE10254956.11,27.htm', 'United States', 'Dedham', 'MA', 'Compliance Technology', 2.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'chronograph', 'Chronograph', 'chronograph.io', 0, 'https://www.glassdoor.com/Overview/Working-at-Chronograph-EI_IE2555715.11,22.htm', 'United States', 'New York', 'NY', 'Information Technology', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'cisco', 'Cisco Systems, Inc.', 'cisco.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Cisco-EI_IE1425.11,16.htm', 'United States', 'San Jose', 'CA', 'Information Technology', 4.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'cleerly', 'Cleerly, LLC', 'cleerly.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Cleerly-EI_IE2367977.11,18.htm', 'United States', 'New York', 'NY', 'Healthcare', 4.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'clickhouse', 'ClickHouse, Inc', 'clickhouse.com', 0, 'https://www.glassdoor.com/Overview/Working-at-ClickHouse-EI_IE6022924.11,21.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 3.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'cocoon-ca', 'Cocoon Financial Services, Inc', 'meetcocoon.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Cocoon-CA-EI_IE6231221.11,20.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 2.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'codepath', 'CodePath.org', 'codepath.org', 0, 'https://www.glassdoor.com/Overview/Working-at-CodePath-EI_IE2352636.11,19.htm', 'United States', 'San Francisco', 'CA', 'Technology Education', 3.7, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'comfrt', 'Comfrt', 'comfrt.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Comfrt-EI_IE10560277.11,17.htm', 'United States', 'New York', 'NY', 'Apparel & Consumer Goods', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'draft', 'ContentFly Inc.', 'contentfly.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Draft-EI_IE2498661.11,16.htm', 'United States', 'Hillsboro', 'OR', 'Information Technology', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'convr', 'Convr', 'convr.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Convr-EI_IE5467572.11,16.htm', 'United States', 'Schaumburg', 'IL', 'Information Technology', 4.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'corporate-tools', 'Corporate Tools LLC', 'corporatetools.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Corporate-Tools-EI_IE1675338.11,26.htm', 'United States', 'Post Falls', 'ID', 'Information Technology', 2.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'cribl', 'Cribl, Inc', 'cribl.io', 0, 'https://www.glassdoor.com/Overview/Working-at-Cribl-EI_IE3299657.11,16.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 4.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'cryptio', 'Cryptio', 'cryptio.co', 0, 'https://www.glassdoor.com/Overview/Working-at-Cryptio-EI_IE6912365.11,18.htm', 'United States', 'Ontario', 'CA', 'Information Technology', 4.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'dataiku', 'Dataiku', 'dataiku.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Dataiku-EI_IE1037713.11,18.htm', 'United States', 'New York', 'NY', 'Information Technology', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'deltek', 'Deltek, Inc.', 'deltek.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Deltek-EI_IE6642.11,17.htm', 'United States', 'Herndon', 'VA', 'Information Technology', 4.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'descript', 'Descript', 'descript.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Descript-EI_IE4674359.11,19.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 4.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'digitalvertex-ent', 'DigitalVertex Enterprises', NULL, 0, 'https://www.glassdoor.com/Overview/Working-at-DigitalVertex-Ent-EI_IE10531028.11,28.htm', 'United States', 'Arlington', 'VA', 'Information Technology', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'subway', 'Doctor''s Associates Inc.', 'subway.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Subway-EI_IE2994.11,17.htm', 'United States', 'Shelton', 'CT', 'Restaurants & Food Service', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'dole-packaged-foods', 'Dole Asia Holdings Pte. Ltd.', 'doledole.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Dole-Packaged-Foods-EI_IE291014.11,30.htm', 'United States', 'Westlake Village', 'CA', 'Manufacturing', 3.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'druva', 'Druva Inc', 'druva.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Druva-EI_IE498047.11,16.htm', 'United States', 'Los Angeles', 'CA', 'Information Technology', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'eversana', 'EVERSANA', 'eversana.com', 0, 'https://www.glassdoor.com/Overview/Working-at-EVERSANA-EI_IE2363465.11,19.htm', 'United States', 'Kansas City', 'MO', 'Pharmaceutical & Biotechnology', 3.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'edmunds-com', 'Edmunds.com, Inc.', 'edmunds.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Edmunds-com-EI_IE21759.11,22.htm', 'United States', 'Santa Monica', 'CA', 'Information Technology', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'egen', 'Egen Solutions, LLC', 'egen.solutions', 0, 'https://www.glassdoor.com/Overview/Working-at-Egen-EI_IE328088.11,15.htm', 'United States', 'Alpharetta', 'GA', 'Information Technology', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'emergent-labs', 'Emergent Labs', 'emergentlabs.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Emergent-Labs-EI_IE7821626.11,24.htm', 'United States', 'San Francisco', 'CA', 'AI Technology', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'empower-pharmacy', 'Empower Pharmacy', 'empowerpharmacy.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Empower-Pharmacy-EI_IE1635431.11,27.htm', 'United States', 'Houston', 'TX', 'Pharmaceutical & Biotechnology', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'engenious', 'Engenious', 'engenious.io', 0, 'https://www.glassdoor.com/Overview/Working-at-Engenious-EI_IE7139958.11,20.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'enterprise-informatics', 'Enterprise Informatics Inc.', 'enterpriseinformatics.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Enterprise-Informatics-EI_IE1111.11,33.htm', 'United States', 'Fort Wayne', 'IN', 'Information Technology', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'epsilon-systems', 'Epsilon Systems Solutions, Inc.', 'epsilonsystems.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Epsilon-Systems-EI_IE28078.11,26.htm', 'United States', 'Wright Patterson AFB', 'OH', 'Construction, Repair & Maintenance Services', 3.7, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'equilibrium-energy', 'Equilibrium Energy, Inc', 'equilibriumenergy.io', 0, 'https://www.glassdoor.com/Overview/Working-at-Equilibrium-Energy-EI_IE6678732.11,29.htm', 'United States', 'San Francisco', 'CA', 'Energy, Mining & Utilities', 4.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'crate-and-barrel', 'Euromarket Designs, Inc.', 'crateandbarrel.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Crate-and-Barrel-EI_IE3866.11,27.htm', 'United States', 'Northbrook', 'IL', 'Retail & Wholesale', 3.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'evolve', 'Evolve Vacation Rental Network', 'evolvevacationrental.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Evolve-EI_IE844063.11,17.htm', 'United States', 'Denver', 'CO', 'Hotels & Travel Accommodation', 3.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'fanduel', 'FanDuel Inc.', 'fanduel.com', 0, 'https://www.glassdoor.com/Overview/Working-at-FanDuel-EI_IE894936.11,18.htm', 'United States', 'New York', 'NY', 'Arts, Entertainment & Recreation', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'feesback-technologies', 'Feesback Technologies Inc.', NULL, 0, 'https://www.glassdoor.com/Overview/Working-at-Feesback-Technologies-EI_IE10497250.11,32.htm', 'United States', 'Chicago', 'IL', 'Financial Technology', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'finalis', 'Finalis', 'finalis.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Finalis-EI_IE4943334.11,18.htm', 'United States', 'San Francisco', 'CA', 'Financial Technology', 3.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'focused-energy', 'Focused Energy GmbH', 'focused-energy.world', 0, 'https://www.glassdoor.com/Overview/Working-at-Focused-Energy-EI_IE8207721.11,25.htm', 'United States', 'Darmstadt', NULL, 'Nuclear Fusion Energy', 2.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'foundation-egi', 'Foundation LLM Technologies, Inc.', 'foundationllm.ai', 0, 'https://www.glassdoor.com/Overview/Working-at-Foundation-EGI-EI_IE10862075.11,25.htm', 'United States', 'Boston', 'MA', 'AI Platform Technology', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'fueled', 'Fueled', 'fueled.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Fueled-EI_IE710513.11,17.htm', 'United States', 'New York', 'NY', 'Information Technology', 2.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'full-circle-leadership', 'Full Circle Leadership', 'fullcircleleadership.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Full-Circle-Leadership-EI_IE2523910.11,33.htm', 'United States', 'Seattle', 'WA', 'Leadership Consulting', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'future', 'Future plc', 'futureplc.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Future-EI_IE350743.11,17.htm', 'United States', 'Bath', NULL, 'Media & Communication', 3.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'future-works', 'Future works', 'futureworks.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Future-works-EI_IE1021167.11,23.htm', 'United States', 'New York', 'NY', 'Marketing Technology', 1.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'futurefeed', 'FutureFeed', 'futurefeed.co', 0, 'https://www.glassdoor.com/Overview/Working-at-FutureFeed-EI_IE6123196.11,21.htm', 'United States', 'Baltimore', 'MD', 'Sustainable Agriculture Technology', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'gama-1-technologies', 'GAMA-1 Technologies', 'gama1.com', 0, 'https://www.glassdoor.com/Overview/Working-at-GAMA-1-Technologies-EI_IE2034616.11,30.htm', 'United States', 'Germantown', 'MD', 'Information Technology', 4.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'gamechanger', 'GameChanger Media Inc', 'gc.com', 0, 'https://www.glassdoor.com/Overview/Working-at-GameChanger-EI_IE784059.11,22.htm', 'United States', 'New York', 'NY', 'Information Technology', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'genworth', 'Genworth Financial, Inc.', 'genworth.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Genworth-EI_IE34925.11,19.htm', 'United States', 'New York', 'NY', 'Insurance', 4.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'geon-technologies', 'Geon Technologies, LLC', 'geontech.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Geon-Technologies-EI_IE2358169.11,28.htm', 'United States', 'Columbia', 'MD', 'Information Technology', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'givzey', 'Givzey Technologies, Inc.', 'givzey.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Givzey-EI_IE9659086.11,17.htm', 'United States', 'Boston', 'MA', 'Nonprofit Fundraising Technology', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'graphicacy', 'Graphicacy', 'graphicacy.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Graphicacy-EI_IE1400817.11,21.htm', 'United States', 'Washington', 'DC', 'Information Technology', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'greatfrontend', 'GreatFrontEnd', 'greatfrontend.com', 0, 'https://www.glassdoor.com/Overview/Working-at-GreatFrontEnd-EI_IE9776909.11,24.htm', 'United States', 'Singapore', NULL, 'Software Engineering Education', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'harman', 'HARMAN International Industries, Incorporated', 'harman.com', 0, 'https://www.glassdoor.com/Overview/Working-at-HARMAN-EI_IE315.11,17.htm', 'United States', 'Stamford', 'CT', 'Manufacturing', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'qcells', 'Hanwha Solutions Co., Ltd.', 'qcells.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Qcells-EI_IE40456.11,17.htm', 'United States', 'Irvine', 'CA', 'Energy, Mining & Utilities', 2.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'haramain-systems', 'Haramain Systems Inc.', NULL, 0, 'https://www.glassdoor.com/Overview/Working-at-Haramain-Systems-EI_IE3170917.11,27.htm', 'United States', 'Eden Prairie', 'MN', 'Human Resources & Staffing', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'harness', 'Harness Inc.', 'harness.io', 0, 'https://www.glassdoor.com/Overview/Working-at-Harness-EI_IE1828521.11,18.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'haven-ca', 'Haven Energy', 'havenenergy.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Haven-CA-EI_IE9360962.11,19.htm', 'United States', 'Brooklyn', 'NY', 'Clean Energy Technology', 2.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'headspace', 'Headspace Inc', 'headspace.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Headspace-EI_IE984335.11,20.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 2.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'hex', 'Hex Technologies, Inc', 'hex.tech', 0, 'https://www.glassdoor.com/Overview/Working-at-Hex-EI_IE8099329.11,14.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'higharc', 'Higharc, Inc.', 'higharc.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Higharc-EI_IE2903110.11,18.htm', 'United States', 'Durham', 'NC', 'Construction, Repair & Maintenance Services', 4.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'hire-with-jarvis', 'Hire With Jarvis', 'hirewithjarvis.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Hire-With-Jarvis-EI_IE8367202.11,27.htm', 'United States', 'New York', 'NY', 'Human Resources & Staffing', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'honor', 'Honor Technology, Inc.', 'honorcare.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Honor-EI_IE1079592.11,16.htm', 'United States', 'San Francisco', 'CA', 'Healthcare', 2.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'horizon-blockchain-games', 'Horizon Blockchain Games Inc.', 'horizon.io', 0, 'https://www.glassdoor.com/Overview/Working-at-Horizon-Blockchain-Games-EI_IE4515569.11,35.htm', 'United States', 'Toronto', 'ON', 'Information Technology', 4.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'icf', 'ICF International, Inc.', 'icf.com', 0, 'https://www.glassdoor.com/Overview/Working-at-ICF-EI_IE18654.11,14.htm', 'United States', 'Reston', 'VA', 'Management & Consulting', 3.7, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'itrade-technologies-stem', 'ITRADE Technologies STEM LLC', 'itradestem.com', 0, 'https://www.glassdoor.com/Overview/Working-at-ITRADE-Technologies-STEM-EI_IE10119549.11,35.htm', 'United States', 'Miami', 'FL', 'Education Technology', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'iunu', 'IUNU', 'iunu.com', 0, 'https://www.glassdoor.com/Overview/Working-at-IUNU-EI_IE1513321.11,15.htm', 'United States', 'Seattle', 'WA', 'Information Technology', 3.7, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'immunitybio', 'ImmunityBio, Inc', 'immunitybio.com', 0, 'https://www.glassdoor.com/Overview/Working-at-ImmunityBio-EI_IE3049116.11,22.htm', 'United States', 'Culver City', 'CA', 'Pharmaceutical & Biotechnology', 2.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'inca-digital', 'Inca Digital', 'incadigital.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Inca-Digital-EI_IE3363476.11,23.htm', 'United States', 'Washington', 'DC', 'Information Technology', 4.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'infinity', 'Infinity', NULL, 0, 'https://www.glassdoor.com/Overview/Working-at-Infinity-EI_IE256963.11,19.htm', 'United States', 'New York', 'NY', 'Media & Communication', 3.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'inspira-financial', 'Inspira Financial Trust, LLC', 'inspirafinancial.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Inspira-Financial-EI_IE843128.11,28.htm', 'United States', 'Oak Brook', 'IL', 'Financial Services', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'invicti-security', 'Invicti Security', 'invicti.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Invicti-Security-EI_IE3367383.11,27.htm', 'United States', 'Austin', 'TX', 'Information Technology', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'invisible-technologies', 'Invisible Technologies Inc.', 'invisible.email', 0, 'https://www.glassdoor.com/Overview/Working-at-Invisible-Technologies-EI_IE2342977.11,33.htm', 'United States', 'Austin', 'TX', 'Information Technology', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'jahnel-group', 'Jahnel Group Inc.', 'jahnelgroup.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Jahnel-Group-EI_IE2121286.11,23.htm', 'United States', 'Schenectady', 'NY', 'Information Technology', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'just-right-reader', 'Just Right Reader', 'justrightreader.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Just-Right-Reader-EI_IE4633831.11,28.htm', 'United States', 'Winston-Salem', 'NC', 'Education', 2.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'justpaid', 'JustPaid', 'justpaid.io', 0, 'https://www.glassdoor.com/Overview/Working-at-JustPaid-EI_IE9241137.11,19.htm', 'United States', 'San Francisco', 'CA', 'B2B Payments Technology', 4.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'keep-company', 'Keep Company', 'keepcompany.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Keep-Company-EI_IE10769279.11,23.htm', 'United States', 'New York', 'NY', 'Workplace Community Platform', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'koyfin', 'Koyfin, Inc.', 'koyfin.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Koyfin-EI_IE2457081.11,17.htm', 'United States', 'New York', 'NY', 'Management & Consulting', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'lakeview-loan-servicing', 'Lakeview Loan Servicing LLC', 'lakeviewloanservicing.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Lakeview-Loan-Servicing-EI_IE703110.11,34.htm', 'United States', 'New York', 'NY', 'Financial Services', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'lightbox', 'LightBox', 'lightboxre.com', 0, 'https://www.glassdoor.com/Overview/Working-at-LightBox-EI_IE3110216.11,19.htm', 'United States', 'New York', 'NY', 'Information Technology', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'liveperson', 'LivePerson, Inc.', 'liveperson.com', 0, 'https://www.glassdoor.com/Overview/Working-at-LivePerson-EI_IE11463.11,21.htm', 'United States', 'New York', 'NY', 'Information Technology', 2.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'lockheed-martin', 'Lockheed Martin Corporation', 'lockheedmartin.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Lockheed-Martin-EI_IE404.11,26.htm', 'United States', 'Colorado Springs', 'CO', 'Aerospace & Defense', 4.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'loot-labs', 'Loot Labs Inc', 'lootlabs.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Loot-Labs-EI_IE9387858.11,20.htm', 'United States', 'Seattle', 'WA', 'Gaming & NFT Technology', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'lumileds', 'Lumileds Holding B.V.', 'lumileds.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Lumileds-EI_IE972940.11,19.htm', 'United States', 'Mexico', 'MO', 'Manufacturing', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'luxury-presence', 'Luxury Presence', 'luxurypresence.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Luxury-Presence-EI_IE2364401.11,26.htm', 'United States', 'Austin', 'TX', 'Information Technology', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'lyra-health', 'Lyra Health', 'lyrahealth.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Lyra-Health-EI_IE1483303.11,22.htm', 'United States', 'Burlingame', 'CA', 'Healthcare', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'lyric', 'Lyric Hospitality, Inc.', 'lyric.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Lyric-EI_IE1424816.11,16.htm', 'United States', 'San Francisco', 'CA', 'Hotels & Travel Accommodation', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'mcim', 'MCIM', 'mcim.io', 0, 'https://www.glassdoor.com/Overview/Working-at-MCIM-EI_IE1041298.11,15.htm', 'United States', 'Glen Allen', 'VA', 'Personal Consumer Services', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'mindbody', 'MINDBODY, Inc.', 'mindbodyonline.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Mindbody-EI_IE319289.11,19.htm', 'United States', 'New York', 'NY', 'Information Technology', 3.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'mark43', 'Mark43', 'mark43.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Mark43-EI_IE1096288.11,17.htm', 'United States', 'New York', 'NY', 'Information Technology', 3.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'medical-informatics-engineering', 'Medical Informatics Engineering Inc.', 'mieweb.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Medical-Informatics-Engineering-EI_IE356423.11,42.htm', 'United States', 'Fort Wayne', 'IN', 'Information Technology', 3.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'melo-tech', 'Melo Tech', 'melotech.io', 0, 'https://www.glassdoor.com/Overview/Working-at-Melo-Tech-EI_IE786167.11,20.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'metrostar-systems', 'MetroStar Systems, Inc.', 'metrostarsystems.com', 0, 'https://www.glassdoor.com/Overview/Working-at-MetroStar-Systems-EI_IE31165.11,28.htm', 'United States', 'Washington', 'DC', 'Information Technology', 4.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'microventures', 'MicroVentures', 'microventures.com', 0, 'https://www.glassdoor.com/Overview/Working-at-MicroVentures-EI_IE978432.11,24.htm', 'United States', 'Austin', 'TX', 'Financial Services', 3.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'mundrisoft-solutions', 'Mundrisoft Solutions', 'mundrisoft.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Mundrisoft-Solutions-EI_IE5338019.11,31.htm', 'United States', 'Newark', 'NJ', 'Information Technology', 4.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'mutual-of-omaha', 'Mutual of Omaha Insurance Company', 'mutualofomaha.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Mutual-of-Omaha-EI_IE3678.11,26.htm', 'United States', 'Omaha', 'NE', 'Insurance', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'n3xt', 'N3XT', 'n3xt.com', 0, 'https://www.glassdoor.com/Overview/Working-at-N3XT-EI_IE1186994.11,15.htm', 'United States', 'Houston', 'TX', 'Energy Technology', 3.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'nike', 'NIKE, Inc.', 'nike.com', 0, 'https://www.glassdoor.com/Overview/Working-at-NIKE-EI_IE1699.11,15.htm', 'United States', 'Beaverton', 'OR', 'Manufacturing', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'netapp', 'NetApp, Inc.', 'netapp.com', 0, 'https://www.glassdoor.com/Overview/Working-at-NetApp-EI_IE5406.11,17.htm', 'United States', 'San Jose', 'CA', 'Information Technology', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'netflix', 'Netflix, Inc.', 'netflix.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Netflix-EI_IE11891.11,18.htm', 'United States', 'Los Gatos', 'CA', 'Information Technology', 4.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'newpage-solutions', 'Newpage Solutions Inc.,', 'newpagesolutions.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Newpage-Solutions-EI_IE3171702.11,28.htm', 'United States', 'Atlanta', 'GA', 'Information Technology', 4.7, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'newrich-network', 'Newrich Consulting Inc', 'newrichnetwork.com', 0, 'https://www.glassdoor.com/Overview/Working-at-NewRich-Network-EI_IE5540194.11,26.htm', 'United States', 'Austin', 'TX', 'Business Consulting', 1.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'nex-tyres', 'Nex Tyres', 'nextyres.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Nex-Tyres-EI_IE5207767.11,20.htm', 'United States', 'Houston', 'TX', 'Automotive Retail', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'nfinity-athletic', 'Nfinity Athletic Corporation', 'nfinityathletic.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Nfinity-Athletic-EI_IE1010389.11,27.htm', 'United States', 'Atlanta', 'GA', 'Retail & Wholesale', 2.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'oura', 'Oura Health Oy', 'ouraring.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Oura-EI_IE2926710.11,15.htm', 'United States', 'Oulu', NULL, 'Information Technology', 3.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'outlive', 'Outlive', 'outlive.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Outlive-EI_IE597183.11,18.htm', 'United States', 'San Diego', 'CA', 'Nonprofit & NGO', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'owner-com', 'Owner.com, Inc.', 'owner.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Owner-com-EI_IE5769842.11,20.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 4.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'pactfi', 'PactFi', 'pactfi.com', 0, 'https://www.glassdoor.com/Overview/Working-at-PactFi-EI_IE11070643.11,17.htm', 'United States', 'New York', 'NY', 'Insurance Technology', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'padsplit', 'PadSplit', 'padsplit.com', 0, 'https://www.glassdoor.com/Overview/Working-at-PadSplit-EI_IE3186668.11,19.htm', 'United States', 'Brazil', 'IN', 'Real Estate', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'pandadoc', 'PandaDoc', 'pandadoc.com', 0, 'https://www.glassdoor.com/Overview/Working-at-PandaDoc-EI_IE776070.11,19.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 3.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'pango-group', 'Pango LLC', 'pango.co', 0, 'https://www.glassdoor.com/Overview/Working-at-Pango-Group-EI_IE8617779.11,22.htm', 'United States', 'Scottsdale', 'AZ', 'Information Technology', 4.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'paperless-post', 'Paperless Post', 'paperlesspost.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Paperless-Post-EI_IE555019.11,25.htm', 'United States', 'New York', 'NY', 'Information Technology', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'penguin-random-house', 'Penguin Random House', 'penguinrandomhouse.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Penguin-Random-House-EI_IE743403.11,31.htm', 'United States', 'New York', 'NY', 'Media & Communication', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'pindrop', 'Pindrop', 'pindrop.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Pindrop-EI_IE709157.11,18.htm', 'United States', 'Atlanta', 'GA', 'Information Technology', 4.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'planetscale', 'PlanetScale, Inc.', 'planetscale.com', 0, 'https://www.glassdoor.com/Overview/Working-at-PlanetScale-EI_IE2148572.11,22.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 3.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'power3-solutions', 'Power3 Solutions', 'power3solutions.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Power3-Solutions-EI_IE5692981.11,27.htm', 'United States', 'Columbia', 'MD', 'IT Solutions', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'prenuvo', 'Prenuvo, Inc.', 'prenuvo.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Prenuvo-EI_IE2603205.11,18.htm', 'United States', 'San Francisco', 'CA', 'Healthcare', 2.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'quantum-computing', 'Quantum Computing Inc.', 'quantumcomputinginc.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Quantum-Computing-EI_IE8428796.11,28.htm', 'United States', 'Leesburg', 'VA', 'Quantum Computing Technology', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'radar', 'Radar', 'radar.io', 0, 'https://www.glassdoor.com/Overview/Working-at-Radar-EI_IE613529.11,16.htm', 'United States', 'New York', 'NY', 'Nonprofit & NGO', 2.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 're-build-manufacturing', 'Re:Build Manufacturing LLC', 'rebuildmanufacturing.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Re-Build-Manufacturing-EI_IE5250344.11,33.htm', 'United States', 'Framingham', 'MA', 'Manufacturing', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'remote', 'Remote Technology, Inc.', 'remote.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Remote-EI_IE3871683.11,17.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'risepoint', 'Risepoint', 'risepoint.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Risepoint-EI_IE454381.11,20.htm', 'United States', 'Dallas', 'TX', 'Education', 3.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'riverside-health', 'Riverside Health System', 'riversideonline.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Riverside-Health-EI_IE27003.11,27.htm', 'United States', 'Newport News', 'VA', 'Healthcare', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'robert-half', 'Robert Half', 'roberthalf.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Robert-Half-EI_IE1838.11,22.htm', 'United States', 'San Ramon', 'CA', 'Human Resources & Staffing', 3.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'sas', 'SAS Institute Inc.', 'sas.com', 0, 'https://www.glassdoor.com/Overview/Working-at-SAS-EI_IE3807.11,14.htm', 'United States', 'Cary', 'NC', 'Information Technology', 4.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'shi-international', 'SHI International Corp.', 'shi.com', 0, 'https://www.glassdoor.com/Overview/Working-at-SHI-International-EI_IE14216.11,28.htm', 'United States', 'Somerset', 'NJ', 'Information Technology', 3.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'smart-apartment-data', 'SMART Apartment Data', 'smartapartmentdata.com', 0, 'https://www.glassdoor.com/Overview/Working-at-SMART-Apartment-Data-EI_IE1004409.11,31.htm', 'United States', 'Denver', 'CO', 'Information Technology', 4.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'stem-search-group', 'STEM Search Group', 'stemsearchgroup.com', 0, 'https://www.glassdoor.com/Overview/Working-at-STEM-Search-Group-EI_IE10272944.11,28.htm', 'United States', 'Charlotte', 'NC', 'Human Resources & Staffing', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'salt-indonesia', 'Salt', 'salt.org', 0, 'https://www.glassdoor.com/Overview/Working-at-Salt-Indonesia-EI_IE2401624.11,25.htm', 'United States', 'Los Angeles', 'CA', 'Financial Services', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'second-door-health', 'Second Door Health Inc.', 'seconddoorhealth.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Second-Door-Health-EI_IE10133935.11,29.htm', 'United States', 'New York', 'NY', 'Mental Health Technology', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'serko', 'Serko Limited', 'serko.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Serko-EI_IE1301249.11,16.htm', 'United States', 'Seattle', 'WA', 'Information Technology', 3.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'service-management-group', 'Service Management Group', 'smg.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Service-Management-Group-EI_IE219697.11,35.htm', 'United States', 'Kansas City', 'MO', 'Information Technology', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'sharprank', 'SharpRank', 'sharprank.com', 0, 'https://www.glassdoor.com/Overview/Working-at-SharpRank-EI_IE9125084.11,20.htm', 'United States', 'Columbus', 'OH', 'Sports Analytics', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'shutterfly', 'Shutterfly, Inc.', 'shutterfly.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Shutterfly-EI_IE38329.11,21.htm', 'United States', 'Redwood City', 'CA', 'Information Technology', 3.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'sidecar-health', 'Sidecar Health', 'sidecarbeach.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Sidecar-Health-EI_IE1959394.11,25.htm', 'United States', 'San Francisco', 'CA', 'Insurance', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'slingshot-aerospace', 'Slingshot Aerospace', 'slingshotaerospace.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Slingshot-Aerospace-EI_IE5626756.11,30.htm', 'United States', 'El Segundo', 'CA', 'Aerospace & Defense', 3.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'smarterdx', 'SmarterDx', 'smarterdx.com', 0, 'https://www.glassdoor.com/Overview/Working-at-SmarterDx-EI_IE8333020.11,20.htm', 'United States', 'New York', 'NY', 'Information Technology', 4.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'smartsheet', 'Smartsheet', 'smartsheet.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Smartsheet-EI_IE438753.11,21.htm', 'United States', 'Seattle', 'WA', 'Information Technology', 3.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'softcrylic', 'Softcrylic LLC', 'softcrylic.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Softcrylic-EI_IE269525.11,21.htm', 'United States', 'Alpharetta', 'GA', 'Information Technology', 4.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'sosolimited', 'Sosolimited', 'sosolimited.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Sosolimited-EI_IE436920.11,22.htm', 'United States', 'Boston', 'MA', 'Media & Communication', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'sourceco', 'SourceCo', 'sourceco.com', 0, 'https://www.glassdoor.com/Overview/Working-at-SourceCo-EI_IE10301702.11,19.htm', 'United States', 'Dallas', 'TX', 'Procurement Technology', 1.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'spear-ai', 'Spear AI', 'spear.ai', 0, 'https://www.glassdoor.com/Overview/Working-at-Spear-AI-EI_IE10797252.11,19.htm', 'United States', 'Washington', 'DC', 'Defense AI Technology', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'spyglass-realty', 'Spyglass Realty and Investments', 'spyglassrealty.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Spyglass-Realty-EI_IE2187716.11,26.htm', 'United States', 'Newport Beach', 'CA', 'Real Estate', 4.7, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'stack-influence', 'Stack Influence Inc', 'stackinfluence.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Stack-Influence-EI_IE8117796.11,26.htm', 'United States', 'Miami', 'FL', 'Influencer Marketing', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'stackblitz', 'StackBlitz', 'stackblitz.com', 0, 'https://www.glassdoor.com/Overview/Working-at-StackBlitz-EI_IE5999460.11,21.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 5.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'step', 'Step Mobile Inc', 'step.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Step-EI_IE3254783.11,15.htm', 'United States', 'Palo Alto', 'CA', 'Information Technology', 3.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'strategic-education-inc', 'Strategic Education, Inc.', 'strategiceducation.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Strategic-Education-Inc-EI_IE2436603.11,34.htm', 'United States', 'Herndon', 'VA', 'Education', 3.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'k12', 'Stride, Inc.', 'k12.com', 0, 'https://www.glassdoor.com/Overview/Working-at-K12-EI_IE42734.11,14.htm', 'United States', 'Herndon', 'VA', 'Education', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'swissborg', 'SwissBorg', 'swissborg.com', 0, 'https://www.glassdoor.com/Overview/Working-at-SwissBorg-EI_IE2101863.11,20.htm', 'United States', 'Lausanne', NULL, 'Financial Services', 4.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'tcpwave', 'TCPWave', 'tcpwave.com', 0, 'https://www.glassdoor.com/Overview/Working-at-TCPWave-EI_IE675891.11,18.htm', 'United States', 'Santa Clara', 'CA', 'Information Technology', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'teaching-strategies', 'Teaching Strategies Inc', 'teachingstrategies.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Teaching-Strategies-EI_IE278324.11,30.htm', 'United States', 'Bethesda', 'MD', 'Education', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'team-velocity', 'Team Velocity', 'teamvelocitymarketing.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Team-Velocity-EI_IE391012.11,24.htm', 'United States', 'Atlanta', 'GA', 'Information Technology', 4.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'textron-aviation', 'Textron Aviation', 'txtav.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Textron-Aviation-EI_IE851254.11,27.htm', 'United States', 'Wichita', 'KS', 'Aerospace & Defense', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'thatgame', 'Thatgamecompany, LLC', 'thatgamecompany.com', 0, 'https://www.glassdoor.com/Overview/Working-at-thatgame-EI_IE2130792.11,19.htm', 'United States', 'Los Angeles', 'CA', 'Information Technology', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'allstate', 'The Allstate Corporation', 'allstate.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Allstate-EI_IE2341.11,19.htm', 'United States', 'Northbrook', 'IL', 'Insurance', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'college-board', 'The College Board', 'collegeboard.org', 0, 'https://www.glassdoor.com/Overview/Working-at-College-Board-EI_IE18437.11,24.htm', 'United States', 'New York', 'NY', 'Education', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'penn-mutual', 'The Penn Mutual Life Insurance Company', 'pennmutual.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Penn-Mutual-EI_IE2930.11,22.htm', 'United States', 'Horsham', 'PA', 'Insurance', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'trajector', 'The Trajector Family of Companies', 'trajectormedical.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Trajector-EI_IE6254073.11,20.htm', 'United States', 'Tampa', 'FL', 'Management & Consulting', 3.8, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'thoughtlab', 'ThoughtLab', 'thoughtlabgroup.com', 0, 'https://www.glassdoor.com/Overview/Working-at-ThoughtLab-EI_IE322343.11,21.htm', 'United States', 'Brazil', 'IN', 'Information Technology', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'topdog-law', 'Topdog Law, Helm Group LLC', 'topdoglaw.com', 0, 'https://www.glassdoor.com/Overview/Working-at-TopDog-Law-EI_IE4373370.11,21.htm', 'United States', 'Philadelphia', 'PA', 'Legal Services', 4.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'topflight-apps', 'Topflight LLC', 'topflightapps.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Topflight-Apps-EI_IE2164557.11,25.htm', 'United States', 'Chicago', 'IL', 'Information Technology', 4.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'tradeblock', 'TradeBlock, Inc.', 'tradeblock.com', 0, 'https://www.glassdoor.com/Overview/Working-at-TradeBlock-EI_IE3149349.11,21.htm', 'United States', 'New York', 'NY', 'Information Technology', 4.6, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'trilogy-innovations', 'Trilogy Innovations', 'trilogyinnovations.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Trilogy-Innovations-EI_IE6356019.11,30.htm', 'United States', 'Colorado Springs', 'CO', 'Information Technology', 4.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'ucardia', 'Ucardia, Inc', 'ucardia.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Ucardia-EI_IE7232934.11,18.htm', 'United States', 'Boston', 'MA', 'Cardiac Health Technology', NULL, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'weshare-health', 'United Faith Ministries, Inc.', 'unitedfaithministries.org', 0, 'https://www.glassdoor.com/Overview/Working-at-WeShare-Health-EI_IE7780237.11,25.htm', 'United States', 'Norfolk', 'VA', 'Healthcare', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'vynyl', 'VYNYL', 'vynyl.com', 0, 'https://www.glassdoor.com/Overview/Working-at-VYNYL-EI_IE1323187.11,16.htm', 'United States', 'Los Angeles', 'CA', 'Information Technology', 4.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'valiant-solutions', 'Valiant Solutions, LLC', 'valiantsolutions.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Valiant-Solutions-EI_IE902774.11,28.htm', 'United States', 'Herndon', 'VA', 'Information Technology', 4.0, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'vanta', 'Vanta Inc.', 'vanta.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Vanta-EI_IE3971334.11,16.htm', 'United States', 'San Francisco', 'CA', 'Information Technology', 3.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'veeva-systems', 'Veeva Systems', 'veeva.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Veeva-Systems-EI_IE459351.11,24.htm', 'United States', 'Pleasanton', 'CA', 'Information Technology', 3.5, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'vercel', 'Vercel Inc.', 'vercel.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Vercel-EI_IE6510369.11,17.htm', 'United States', 'Austin', 'NY', 'Information Technology', 4.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'veritone', 'Veritone, Inc.', 'veritone.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Veritone-EI_IE1043171.11,19.htm', 'United States', 'Costa Mesa', 'CA', 'Information Technology', 2.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'versapay', 'VersaPay Corporation', 'versapay.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Versapay-EI_IE342629.11,19.htm', 'United States', 'Atlanta', 'GA', 'Financial Services', 3.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'versant-media', 'Versant Media, LLC', 'versantmedia.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Versant-Media-EI_IE10989296.11,24.htm', 'United States', 'Orlando', 'FL', 'Media & Communication', 4.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'voltaiq', 'Voltaiq', 'voltaiq.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Voltaiq-EI_IE2476462.11,18.htm', 'United States', 'Brooklyn', 'NY', 'Information Technology', 3.9, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'webstacks', 'Webstacks', 'webstacks.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Webstacks-EI_IE3518453.11,20.htm', 'United States', 'San Diego', 'CA', 'Information Technology', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'whisker-labs', 'Whisker Labs', 'whiskerlabs.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Whisker-Labs-EI_IE1428401.11,23.htm', 'United States', 'Bethesda', 'MD', 'Information Technology', 3.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'workos', 'WorkOS', 'workos.com', 0, 'https://www.glassdoor.com/Overview/Working-at-WorkOS-EI_IE4609033.11,17.htm', 'United States', 'San Francisco', 'CA', 'Enterprise Authentication', 4.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'world-wide-technology', 'World Wide Technology, Inc.', 'wwt.com', 0, 'https://www.glassdoor.com/Overview/Working-at-World-Wide-Technology-EI_IE9553.11,32.htm', 'United States', 'St. Louis', 'MO', 'Information Technology', 4.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'xion', 'XION GmbH', 'xion.global', 0, 'https://www.glassdoor.com/Overview/Working-at-XION-EI_IE1644828.11,15.htm', 'United States', 'Berlin', NULL, 'Blockchain Technology', 4.1, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'zone-5-technologies', 'Zone 5 Technologies, LLC', 'zone5tech.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Zone-5-Technologies-EI_IE7952587.11,30.htm', 'United States', 'San Luis Obispo', 'CA', 'Aerospace & Defense', 4.3, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'zwift', 'Zwift, Inc.', 'zwift.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Zwift-EI_IE1186707.11,16.htm', 'United States', 'Long Beach', 'CA', 'Information Technology', 3.2, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;

INSERT INTO "public"."companies" (id, slug, display_name, primary_domain, inspection_count, glassdoor_url, hq_country, hq_city, hq_region, industry, glassdoor_rating, glassdoor_refreshed_at, created_at)
VALUES (gen_random_uuid(), 'impiricus', 'mpiricusHealth Corp', 'mpiricushealth.com', 0, 'https://www.glassdoor.com/Overview/Working-at-Impiricus-EI_IE8091723.11,20.htm', 'United States', 'Atlanta', 'GA', 'Pharmaceutical & Biotechnology', 4.4, '2026-05-22 22:06:17.088188+00', NOW())
ON CONFLICT (slug) DO UPDATE SET
  display_name          = EXCLUDED.display_name,
  primary_domain        = COALESCE("public"."companies".primary_domain, EXCLUDED.primary_domain),
  glassdoor_url         = COALESCE("public"."companies".glassdoor_url, EXCLUDED.glassdoor_url),
  hq_country            = COALESCE("public"."companies".hq_country, EXCLUDED.hq_country),
  hq_city               = COALESCE("public"."companies".hq_city, EXCLUDED.hq_city),
  hq_region             = COALESCE("public"."companies".hq_region, EXCLUDED.hq_region),
  industry              = COALESCE("public"."companies".industry, EXCLUDED.industry),
  glassdoor_rating      = COALESCE("public"."companies".glassdoor_rating, EXCLUDED.glassdoor_rating),
  glassdoor_refreshed_at = COALESCE("public"."companies".glassdoor_refreshed_at, EXCLUDED.glassdoor_refreshed_at)
;
