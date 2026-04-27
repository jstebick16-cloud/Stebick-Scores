--Best Teams by Away/Netural Effciency
SELECT
    "YEAR",
    "TEAM", "SEED", "ROUND", "BADJ EM", "BADJ O", "BADJ D", "BARTHAG", "WAB"
    From bartt_away_neutral
    ORDER BY "BADJ EM" DESC;

-- Champions Shooting Splits
SELECT champions."Winner", shooting_splits."YEAR", shooting_splits."DUNKS FG%", shooting_splits."THREES FG%"
FROM shooting_splits
JOIN champions
ON shooting_splits."TEAM" = champions."Winner"
AND shooting_splits."YEAR" = champions."Year"
ORDER BY shooting_splits."YEAR";

-- Final Four Locations and Champions
SELECT champions."Year", champions."Winner", final_four_locations."City", final_four_locations."State"
FROM champions
JOIN final_four_locations
ON champions."Year" = final_four_locations."Year";

-- Champions and Their Regular Season Profile
SELECT champions."Year",
       champions."Winner",
       bartt_away_neutral."BADJ EM",
       bartt_away_neutral."BADJ O",
       bartt_away_neutral."BADJ D",
       bartt_away_neutral."BARTHAG",
       bartt_away_neutral."WAB",
       resumes."RESUME",
       resumes."Q1 W",
       resumes."Q1 PLUS Q2 W"
FROM champions
JOIN bartt_away_neutral
ON  champions."Year" = bartt_away_neutral."YEAR"
AND champions."Winner" = bartt_away_neutral."TEAM"
JOIN resumes
ON champions."Year" = resumes."YEAR"
AND bartt_away_neutral."TEAM NO" = resumes."TEAM NO"
ORDER BY champions."Year" DESC;

-- Resume, Efficiency, Shooting, and Tournament Success
SELECT
       bartt_away_neutral."YEAR",
       bartt_away_neutral."TEAM",
       bartt_away_neutral."SEED",
       bartt_away_neutral."ROUND",
       bartt_away_neutral."BADJ EM",
       bartt_away_neutral."BADJ O",
       bartt_away_neutral."BADJ D",
       bartt_away_neutral."BARTHAG",
       bartt_away_neutral."WAB",
       resumes."RESUME",
       resumes."Q1 W",
       resumes."Q2 W",
       resumes."Q3 Q4 L",
       shooting_splits."THREES FG%",
       shooting_splits."THREES SHARE",
       shooting_splits."CLOSE TWOS FG%",
       shooting_splits."DUNKS SHARE"
FROM bartt_away_neutral
JOIN resumes
ON bartt_away_neutral."YEAR" = resumes."YEAR"
AND bartt_away_neutral."TEAM NO" = resumes."TEAM NO"
JOIN shooting_splits
ON bartt_away_neutral."YEAR" = shooting_splits."YEAR"
AND bartt_away_neutral."TEAM NO" = shooting_splits."TEAM NO"
ORDER BY bartt_away_neutral."YEAR" DESC,
         bartt_away_neutral."ROUND" DESC;

-- Average Efficiency by Tournamnet Round
SELECT
    bartt_away_neutral."ROUND",
    AVG("BADJ EM") AS avg_badj_em
FROM bartt_away_neutral
GROUP BY bartt_away_neutral."ROUND"
ORDER BY bartt_away_neutral."ROUND";

-- Average Seed by Round Reached
SELECT bartt_away_neutral."ROUND",
       AVG(bartt_away_neutral."SEED") as avg_seed
FROM bartt_away_neutral
GROUP BY bartt_away_neutral."ROUND"
ORDER BY bartt_away_neutral."ROUND";

-- Number of Teams per Seed Making Deep Runs
SELECT "SEED",
       COUNT(*) AS teams
FROM bartt_away_neutral
WHERE "ROUND" >= 4
GROUP BY "SEED"
ORDER BY "SEED";

-- Champion Seed Frequency
SELECT
    "SEED",
    COUNT(*) AS championships
FROM bartt_away_neutral
JOIN champions
ON bartt_away_neutral."YEAR" = champions."Year"
AND bartt_away_neutral."TEAM" = champions."Winner"
GROUP BY "SEED"
ORDER BY "SEED";

-- Resume Score vs. Tournament Success
SELECT
    resumes."RESUME",
    bartt_away_neutral."ROUND"
FROM resumes
JOIN bartt_away_neutral
ON resumes."YEAR" = bartt_away_neutral."YEAR"
AND resumes."TEAM NO" = bartt_away_neutral."TEAM NO";

-- BADJ EM Distribution by Seed
SELECT
    "SEED",
    AVG("BADJ EM")
FROM bartt_away_neutral
WHERE "SEED" <= 16
group by "SEED";