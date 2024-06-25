{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "d5f4ba6b",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "papermill": {
     "duration": 0.016352,
     "end_time": "2024-06-25T09:56:19.468225",
     "exception": false,
     "start_time": "2024-06-25T09:56:19.451873",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Preview\n",
    "Welcome to the **Cyclistic bike-share analysis case study**! A bike-share program that features more than 5,800 bicycles and 600 docking stations. \n",
    "\n",
    "Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.\n",
    "\n",
    "Moreno, the director of marketing and manager has set a clear goal: **Design marketing strategies aimed at converting casual riders into annual members**. In order to do that, however, the team needs to better understand how annual members and casual riders differ. This will be done by analyzing the Cyclistic historical bike trip data to identify trends.\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7c44a284",
   "metadata": {
    "papermill": {
     "duration": 0.015247,
     "end_time": "2024-06-25T09:56:19.499326",
     "exception": false,
     "start_time": "2024-06-25T09:56:19.484079",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Load packages\n",
    "* Start by installing `tidyverse` package:"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "0c2fd953",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:19.536150Z",
     "iopub.status.busy": "2024-06-25T09:56:19.533503Z",
     "iopub.status.idle": "2024-06-25T09:56:35.537504Z",
     "shell.execute_reply": "2024-06-25T09:56:35.535443Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 16.025182,
     "end_time": "2024-06-25T09:56:35.540394",
     "exception": false,
     "start_time": "2024-06-25T09:56:19.515212",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into ‘/usr/local/lib/R/site-library’\n",
      "(as ‘lib’ is unspecified)\n",
      "\n"
     ]
    }
   ],
   "source": [
    "install.packages(\"tidyverse\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "290a565d",
   "metadata": {
    "papermill": {
     "duration": 0.01552,
     "end_time": "2024-06-25T09:56:35.572482",
     "exception": false,
     "start_time": "2024-06-25T09:56:35.556962",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Load packages by using the `library()` function. Use the conflicted package to manage conflicts."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "f5216996",
   "metadata": {
    "_kg_hide-input": true,
    "_kg_hide-output": false,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:35.654791Z",
     "iopub.status.busy": "2024-06-25T09:56:35.605955Z",
     "iopub.status.idle": "2024-06-25T09:56:36.444437Z",
     "shell.execute_reply": "2024-06-25T09:56:36.440871Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.860279,
     "end_time": "2024-06-25T09:56:36.448669",
     "exception": false,
     "start_time": "2024-06-25T09:56:35.588390",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────── tidyverse 2.0.0 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.1.4     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.1.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.0     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.5.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 3.4.4     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.2.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.3     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.0.2     \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n"
     ]
    }
   ],
   "source": [
    "library(tidyverse)\n",
    "library(conflicted)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a03c94f5",
   "metadata": {
    "papermill": {
     "duration": 0.019054,
     "end_time": "2024-06-25T09:56:36.489167",
     "exception": false,
     "start_time": "2024-06-25T09:56:36.470113",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Set dplyr::filter and dplyr::lag as the default choices"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "f4b437b9",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:36.532237Z",
     "iopub.status.busy": "2024-06-25T09:56:36.530047Z",
     "iopub.status.idle": "2024-06-25T09:56:36.709105Z",
     "shell.execute_reply": "2024-06-25T09:56:36.707255Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.20001,
     "end_time": "2024-06-25T09:56:36.711769",
     "exception": false,
     "start_time": "2024-06-25T09:56:36.511759",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m\u001b[90m[conflicted]\u001b[39m Will prefer \u001b[1m\u001b[34mdplyr\u001b[39m\u001b[22m::filter over any other package.\n",
      "\u001b[1m\u001b[22m\u001b[90m[conflicted]\u001b[39m Will prefer \u001b[1m\u001b[34mdplyr\u001b[39m\u001b[22m::lag over any other package.\n"
     ]
    }
   ],
   "source": [
    "conflict_prefer(\"filter\", \"dplyr\")\n",
    "conflict_prefer(\"lag\", \"dplyr\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1f685bb4",
   "metadata": {
    "papermill": {
     "duration": 0.016125,
     "end_time": "2024-06-25T09:56:36.743793",
     "exception": false,
     "start_time": "2024-06-25T09:56:36.727668",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Import data  \n",
    "* Use `read_csv()` function to import data from a .csv in the project folder called \"Divvy_Trips_2019_Q1.csv\" and save as a data frame called \"project_2019_Q1\""
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "560995f9",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:36.779698Z",
     "iopub.status.busy": "2024-06-25T09:56:36.778086Z",
     "iopub.status.idle": "2024-06-25T09:56:40.689144Z",
     "shell.execute_reply": "2024-06-25T09:56:40.687076Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 3.932044,
     "end_time": "2024-06-25T09:56:40.691660",
     "exception": false,
     "start_time": "2024-06-25T09:56:36.759616",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1mRows: \u001b[22m\u001b[34m365069\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m12\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (4): from_station_name, to_station_name, usertype, gender\n",
      "\u001b[32mdbl\u001b[39m  (5): trip_id, bikeid, from_station_id, to_station_id, birthyear\n",
      "\u001b[32mnum\u001b[39m  (1): tripduration\n",
      "\u001b[34mdttm\u001b[39m (2): start_time, end_time\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m426887\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, start_station_name, end_station_name, memb...\n",
      "\u001b[32mdbl\u001b[39m  (6): start_station_id, end_station_id, start_lat, start_lng, end_lat, e...\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n"
     ]
    }
   ],
   "source": [
    "Q1_2019 <- read_csv(\"/kaggle/input/cyclistic-data/Divvy_Trips_2019_Q1.csv\") \n",
    "Q1_2020 <- read_csv(\"/kaggle/input/cyclistic-data/Divvy_Trips_2020_Q1.csv\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "9a92d4de",
   "metadata": {
    "papermill": {
     "duration": 0.01642,
     "end_time": "2024-06-25T09:56:40.725043",
     "exception": false,
     "start_time": "2024-06-25T09:56:40.708623",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Wrangle data and combine into a single file  \n",
    "* Compare the column names of each of the files as they need to match perfectly before using a command to join them into one file"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "c38d0d1b",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:40.761575Z",
     "iopub.status.busy": "2024-06-25T09:56:40.759952Z",
     "iopub.status.idle": "2024-06-25T09:56:40.788000Z",
     "shell.execute_reply": "2024-06-25T09:56:40.785705Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.049514,
     "end_time": "2024-06-25T09:56:40.791027",
     "exception": false,
     "start_time": "2024-06-25T09:56:40.741513",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'trip_id'</li><li>'start_time'</li><li>'end_time'</li><li>'bikeid'</li><li>'tripduration'</li><li>'from_station_id'</li><li>'from_station_name'</li><li>'to_station_id'</li><li>'to_station_name'</li><li>'usertype'</li><li>'gender'</li><li>'birthyear'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'trip\\_id'\n",
       "\\item 'start\\_time'\n",
       "\\item 'end\\_time'\n",
       "\\item 'bikeid'\n",
       "\\item 'tripduration'\n",
       "\\item 'from\\_station\\_id'\n",
       "\\item 'from\\_station\\_name'\n",
       "\\item 'to\\_station\\_id'\n",
       "\\item 'to\\_station\\_name'\n",
       "\\item 'usertype'\n",
       "\\item 'gender'\n",
       "\\item 'birthyear'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'trip_id'\n",
       "2. 'start_time'\n",
       "3. 'end_time'\n",
       "4. 'bikeid'\n",
       "5. 'tripduration'\n",
       "6. 'from_station_id'\n",
       "7. 'from_station_name'\n",
       "8. 'to_station_id'\n",
       "9. 'to_station_name'\n",
       "10. 'usertype'\n",
       "11. 'gender'\n",
       "12. 'birthyear'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"trip_id\"           \"start_time\"        \"end_time\"         \n",
       " [4] \"bikeid\"            \"tripduration\"      \"from_station_id\"  \n",
       " [7] \"from_station_name\" \"to_station_id\"     \"to_station_name\"  \n",
       "[10] \"usertype\"          \"gender\"            \"birthyear\"        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colnames(Q1_2019)\n",
    "colnames(Q1_2020)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "3f46c043",
   "metadata": {
    "papermill": {
     "duration": 0.017959,
     "end_time": "2024-06-25T09:56:40.825932",
     "exception": false,
     "start_time": "2024-06-25T09:56:40.807973",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Rename Q1_2019 columns to make them consistent with Q1_2020"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "7e2132b6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:40.862668Z",
     "iopub.status.busy": "2024-06-25T09:56:40.861101Z",
     "iopub.status.idle": "2024-06-25T09:56:40.924683Z",
     "shell.execute_reply": "2024-06-25T09:56:40.922946Z"
    },
    "papermill": {
     "duration": 0.085305,
     "end_time": "2024-06-25T09:56:40.927796",
     "exception": false,
     "start_time": "2024-06-25T09:56:40.842491",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "Q1_2019 <- rename(Q1_2019\n",
    "                   ,ride_id = trip_id\n",
    "                   ,rideable_type = bikeid\n",
    "                   ,started_at = start_time\n",
    "                   ,ended_at = end_time\n",
    "                   ,start_station_name = from_station_name\n",
    "                   ,start_station_id = from_station_id\n",
    "                   ,end_station_name = to_station_name\n",
    "                   ,end_station_id = to_station_id\n",
    "                   ,member_casual = usertype\n",
    ")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "9f825caf",
   "metadata": {
    "papermill": {
     "duration": 0.016265,
     "end_time": "2024-06-25T09:56:40.960494",
     "exception": false,
     "start_time": "2024-06-25T09:56:40.944229",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Inspect the data frames and look for incongruencies"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "780eb2c2",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:40.996711Z",
     "iopub.status.busy": "2024-06-25T09:56:40.995151Z",
     "iopub.status.idle": "2024-06-25T09:56:41.305351Z",
     "shell.execute_reply": "2024-06-25T09:56:41.302946Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.331955,
     "end_time": "2024-06-25T09:56:41.308630",
     "exception": false,
     "start_time": "2024-06-25T09:56:40.976675",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "spc_tbl_ [365,069 × 12] (S3: spec_tbl_df/tbl_df/tbl/data.frame)\n",
      " $ ride_id           : num [1:365069] 21742443 21742444 21742445 21742446 21742447 ...\n",
      " $ started_at        : POSIXct[1:365069], format: \"2019-01-01 00:04:37\" \"2019-01-01 00:08:13\" ...\n",
      " $ ended_at          : POSIXct[1:365069], format: \"2019-01-01 00:11:07\" \"2019-01-01 00:15:34\" ...\n",
      " $ rideable_type     : num [1:365069] 2167 4386 1524 252 1170 ...\n",
      " $ tripduration      : num [1:365069] 390 441 829 1783 364 ...\n",
      " $ start_station_id  : num [1:365069] 199 44 15 123 173 98 98 211 150 268 ...\n",
      " $ start_station_name: chr [1:365069] \"Wabash Ave & Grand Ave\" \"State St & Randolph St\" \"Racine Ave & 18th St\" \"California Ave & Milwaukee Ave\" ...\n",
      " $ end_station_id    : num [1:365069] 84 624 644 176 35 49 49 142 148 141 ...\n",
      " $ end_station_name  : chr [1:365069] \"Milwaukee Ave & Grand Ave\" \"Dearborn St & Van Buren St (*)\" \"Western Ave & Fillmore St (*)\" \"Clark St & Elm St\" ...\n",
      " $ member_casual     : chr [1:365069] \"Subscriber\" \"Subscriber\" \"Subscriber\" \"Subscriber\" ...\n",
      " $ gender            : chr [1:365069] \"Male\" \"Female\" \"Female\" \"Male\" ...\n",
      " $ birthyear         : num [1:365069] 1989 1990 1994 1993 1994 ...\n",
      " - attr(*, \"spec\")=\n",
      "  .. cols(\n",
      "  ..   trip_id = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   start_time = \u001b[34mcol_datetime(format = \"\")\u001b[39m,\n",
      "  ..   end_time = \u001b[34mcol_datetime(format = \"\")\u001b[39m,\n",
      "  ..   bikeid = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   tripduration = \u001b[32mcol_number()\u001b[39m,\n",
      "  ..   from_station_id = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   from_station_name = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   to_station_id = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   to_station_name = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   usertype = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   gender = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   birthyear = \u001b[32mcol_double()\u001b[39m\n",
      "  .. )\n",
      " - attr(*, \"problems\")=<externalptr> \n",
      "spc_tbl_ [426,887 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)\n",
      " $ ride_id           : chr [1:426887] \"EACB19130B0CDA4A\" \"8FED874C809DC021\" \"789F3C21E472CA96\" \"C9A388DAC6ABF313\" ...\n",
      " $ rideable_type     : chr [1:426887] \"docked_bike\" \"docked_bike\" \"docked_bike\" \"docked_bike\" ...\n",
      " $ started_at        : POSIXct[1:426887], format: \"2020-01-21 20:06:59\" \"2020-01-30 14:22:39\" ...\n",
      " $ ended_at          : POSIXct[1:426887], format: \"2020-01-21 20:14:30\" \"2020-01-30 14:26:22\" ...\n",
      " $ start_station_name: chr [1:426887] \"Western Ave & Leland Ave\" \"Clark St & Montrose Ave\" \"Broadway & Belmont Ave\" \"Clark St & Randolph St\" ...\n",
      " $ start_station_id  : num [1:426887] 239 234 296 51 66 212 96 96 212 38 ...\n",
      " $ end_station_name  : chr [1:426887] \"Clark St & Leland Ave\" \"Southport Ave & Irving Park Rd\" \"Wilton Ave & Belmont Ave\" \"Fairbanks Ct & Grand Ave\" ...\n",
      " $ end_station_id    : num [1:426887] 326 318 117 24 212 96 212 212 96 100 ...\n",
      " $ start_lat         : num [1:426887] 42 42 41.9 41.9 41.9 ...\n",
      " $ start_lng         : num [1:426887] -87.7 -87.7 -87.6 -87.6 -87.6 ...\n",
      " $ end_lat           : num [1:426887] 42 42 41.9 41.9 41.9 ...\n",
      " $ end_lng           : num [1:426887] -87.7 -87.7 -87.7 -87.6 -87.6 ...\n",
      " $ member_casual     : chr [1:426887] \"member\" \"member\" \"member\" \"member\" ...\n",
      " - attr(*, \"spec\")=\n",
      "  .. cols(\n",
      "  ..   ride_id = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   rideable_type = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   started_at = \u001b[34mcol_datetime(format = \"\")\u001b[39m,\n",
      "  ..   ended_at = \u001b[34mcol_datetime(format = \"\")\u001b[39m,\n",
      "  ..   start_station_name = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   start_station_id = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   end_station_name = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   end_station_id = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   start_lat = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   start_lng = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   end_lat = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   end_lng = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   member_casual = \u001b[31mcol_character()\u001b[39m\n",
      "  .. )\n",
      " - attr(*, \"problems\")=<externalptr> \n"
     ]
    }
   ],
   "source": [
    "str(Q1_2019)\n",
    "str(Q1_2020)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b3368498",
   "metadata": {
    "papermill": {
     "duration": 0.049811,
     "end_time": "2024-06-25T09:56:41.375483",
     "exception": false,
     "start_time": "2024-06-25T09:56:41.325672",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Convert ride_id and rideable_type to character so that they can stack correctly. These columns are in character data types in the Q1_2020 data"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "8c3eb719",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:41.413361Z",
     "iopub.status.busy": "2024-06-25T09:56:41.411749Z",
     "iopub.status.idle": "2024-06-25T09:56:41.439597Z",
     "shell.execute_reply": "2024-06-25T09:56:41.437657Z"
    },
    "papermill": {
     "duration": 0.050732,
     "end_time": "2024-06-25T09:56:41.442880",
     "exception": false,
     "start_time": "2024-06-25T09:56:41.392148",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "Q1_2019 <-  mutate(Q1_2019, ride_id = as.character(ride_id)\n",
    "                   ,rideable_type = as.character(rideable_type))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1d3cdf12",
   "metadata": {
    "papermill": {
     "duration": 0.016687,
     "end_time": "2024-06-25T09:56:41.476386",
     "exception": false,
     "start_time": "2024-06-25T09:56:41.459699",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Stack individual quarter's data frames into one big data frame"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "111ea9ab",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:41.513746Z",
     "iopub.status.busy": "2024-06-25T09:56:41.512175Z",
     "iopub.status.idle": "2024-06-25T09:56:43.287055Z",
     "shell.execute_reply": "2024-06-25T09:56:43.285172Z"
    },
    "papermill": {
     "duration": 1.797196,
     "end_time": "2024-06-25T09:56:43.290424",
     "exception": false,
     "start_time": "2024-06-25T09:56:41.493228",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips <- bind_rows(Q1_2019, Q1_2020)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "38d882c8",
   "metadata": {
    "papermill": {
     "duration": 0.017066,
     "end_time": "2024-06-25T09:56:43.324439",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.307373",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Remove lat, long, birthyear, and gender fields as this data was dropped in the beginning in 2020"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "a6dba6ca",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:43.363082Z",
     "iopub.status.busy": "2024-06-25T09:56:43.361490Z",
     "iopub.status.idle": "2024-06-25T09:56:43.384533Z",
     "shell.execute_reply": "2024-06-25T09:56:43.382761Z"
    },
    "papermill": {
     "duration": 0.045864,
     "end_time": "2024-06-25T09:56:43.387742",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.341878",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips <- all_trips %>%  \n",
    "  select(-c(\"start_lat\", \"start_lng\", \"end_lat\", \"end_lng\", \"birthyear\", \"gender\",  \"tripduration\"))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "64892db8",
   "metadata": {
    "papermill": {
     "duration": 0.016873,
     "end_time": "2024-06-25T09:56:43.421882",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.405009",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Clean up and add data to prepare for analysis\n",
    "\n",
    "**Inspect the new table that has been created**\n",
    "* List of column names"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "635ecee7",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:43.460613Z",
     "iopub.status.busy": "2024-06-25T09:56:43.459036Z",
     "iopub.status.idle": "2024-06-25T09:56:43.479681Z",
     "shell.execute_reply": "2024-06-25T09:56:43.477596Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.044032,
     "end_time": "2024-06-25T09:56:43.482754",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.438722",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'started_at'</li><li>'ended_at'</li><li>'rideable_type'</li><li>'start_station_id'</li><li>'start_station_name'</li><li>'end_station_id'</li><li>'end_station_name'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'started_at'\n",
       "3. 'ended_at'\n",
       "4. 'rideable_type'\n",
       "5. 'start_station_id'\n",
       "6. 'start_station_name'\n",
       "7. 'end_station_id'\n",
       "8. 'end_station_name'\n",
       "9. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"ride_id\"            \"started_at\"         \"ended_at\"          \n",
       "[4] \"rideable_type\"      \"start_station_id\"   \"start_station_name\"\n",
       "[7] \"end_station_id\"     \"end_station_name\"   \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colnames(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "5940c474",
   "metadata": {
    "papermill": {
     "duration": 0.017105,
     "end_time": "2024-06-25T09:56:43.517038",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.499933",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* How many rows are in data frame?"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "6972390b",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:43.554993Z",
     "iopub.status.busy": "2024-06-25T09:56:43.553361Z",
     "iopub.status.idle": "2024-06-25T09:56:43.573467Z",
     "shell.execute_reply": "2024-06-25T09:56:43.571207Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.042476,
     "end_time": "2024-06-25T09:56:43.576513",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.534037",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "791956"
      ],
      "text/latex": [
       "791956"
      ],
      "text/markdown": [
       "791956"
      ],
      "text/plain": [
       "[1] 791956"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "nrow(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "fbd1d7e5",
   "metadata": {
    "papermill": {
     "duration": 0.01721,
     "end_time": "2024-06-25T09:56:43.610578",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.593368",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Dimensions of the data frame?"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "aa0cea69",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:43.649002Z",
     "iopub.status.busy": "2024-06-25T09:56:43.647413Z",
     "iopub.status.idle": "2024-06-25T09:56:43.665901Z",
     "shell.execute_reply": "2024-06-25T09:56:43.664209Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.04003,
     "end_time": "2024-06-25T09:56:43.668118",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.628088",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>791956</li><li>9</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 791956\n",
       "\\item 9\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 791956\n",
       "2. 9\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 791956      9"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "dim(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "929c7d4f",
   "metadata": {
    "papermill": {
     "duration": 0.017418,
     "end_time": "2024-06-25T09:56:43.702865",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.685447",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* See the first 6 rows of data frame"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "2447cd61",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:43.741481Z",
     "iopub.status.busy": "2024-06-25T09:56:43.739867Z",
     "iopub.status.idle": "2024-06-25T09:56:43.789498Z",
     "shell.execute_reply": "2024-06-25T09:56:43.787678Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.071574,
     "end_time": "2024-06-25T09:56:43.792029",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.720455",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>ride_id</th><th scope=col>started_at</th><th scope=col>ended_at</th><th scope=col>rideable_type</th><th scope=col>start_station_id</th><th scope=col>start_station_name</th><th scope=col>end_station_id</th><th scope=col>end_station_name</th><th scope=col>member_casual</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>21742443</td><td>2019-01-01 00:04:37</td><td>2019-01-01 00:11:07</td><td>2167</td><td>199</td><td><span style=white-space:pre-wrap>Wabash Ave &amp; Grand Ave             </span></td><td> 84</td><td><span style=white-space:pre-wrap>Milwaukee Ave &amp; Grand Ave     </span></td><td>Subscriber</td></tr>\n",
       "\t<tr><td>21742444</td><td>2019-01-01 00:08:13</td><td>2019-01-01 00:15:34</td><td>4386</td><td> 44</td><td><span style=white-space:pre-wrap>State St &amp; Randolph St             </span></td><td>624</td><td>Dearborn St &amp; Van Buren St (*)</td><td>Subscriber</td></tr>\n",
       "\t<tr><td>21742445</td><td>2019-01-01 00:13:23</td><td>2019-01-01 00:27:12</td><td>1524</td><td> 15</td><td><span style=white-space:pre-wrap>Racine Ave &amp; 18th St               </span></td><td>644</td><td>Western Ave &amp; Fillmore St (*) </td><td>Subscriber</td></tr>\n",
       "\t<tr><td>21742446</td><td>2019-01-01 00:13:45</td><td>2019-01-01 00:43:28</td><td>252 </td><td>123</td><td><span style=white-space:pre-wrap>California Ave &amp; Milwaukee Ave     </span></td><td>176</td><td><span style=white-space:pre-wrap>Clark St &amp; Elm St             </span></td><td>Subscriber</td></tr>\n",
       "\t<tr><td>21742447</td><td>2019-01-01 00:14:52</td><td>2019-01-01 00:20:56</td><td>1170</td><td>173</td><td>Mies van der Rohe Way &amp; Chicago Ave</td><td> 35</td><td><span style=white-space:pre-wrap>Streeter Dr &amp; Grand Ave       </span></td><td>Subscriber</td></tr>\n",
       "\t<tr><td>21742448</td><td>2019-01-01 00:15:33</td><td>2019-01-01 00:19:09</td><td>2437</td><td> 98</td><td><span style=white-space:pre-wrap>LaSalle St &amp; Washington St         </span></td><td> 49</td><td><span style=white-space:pre-wrap>Dearborn St &amp; Monroe St       </span></td><td>Subscriber</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " ride\\_id & started\\_at & ended\\_at & rideable\\_type & start\\_station\\_id & start\\_station\\_name & end\\_station\\_id & end\\_station\\_name & member\\_casual\\\\\n",
       " <chr> & <dttm> & <dttm> & <chr> & <dbl> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t 21742443 & 2019-01-01 00:04:37 & 2019-01-01 00:11:07 & 2167 & 199 & Wabash Ave \\& Grand Ave              &  84 & Milwaukee Ave \\& Grand Ave      & Subscriber\\\\\n",
       "\t 21742444 & 2019-01-01 00:08:13 & 2019-01-01 00:15:34 & 4386 &  44 & State St \\& Randolph St              & 624 & Dearborn St \\& Van Buren St (*) & Subscriber\\\\\n",
       "\t 21742445 & 2019-01-01 00:13:23 & 2019-01-01 00:27:12 & 1524 &  15 & Racine Ave \\& 18th St                & 644 & Western Ave \\& Fillmore St (*)  & Subscriber\\\\\n",
       "\t 21742446 & 2019-01-01 00:13:45 & 2019-01-01 00:43:28 & 252  & 123 & California Ave \\& Milwaukee Ave      & 176 & Clark St \\& Elm St              & Subscriber\\\\\n",
       "\t 21742447 & 2019-01-01 00:14:52 & 2019-01-01 00:20:56 & 1170 & 173 & Mies van der Rohe Way \\& Chicago Ave &  35 & Streeter Dr \\& Grand Ave        & Subscriber\\\\\n",
       "\t 21742448 & 2019-01-01 00:15:33 & 2019-01-01 00:19:09 & 2437 &  98 & LaSalle St \\& Washington St          &  49 & Dearborn St \\& Monroe St        & Subscriber\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 9\n",
       "\n",
       "| ride_id &lt;chr&gt; | started_at &lt;dttm&gt; | ended_at &lt;dttm&gt; | rideable_type &lt;chr&gt; | start_station_id &lt;dbl&gt; | start_station_name &lt;chr&gt; | end_station_id &lt;dbl&gt; | end_station_name &lt;chr&gt; | member_casual &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| 21742443 | 2019-01-01 00:04:37 | 2019-01-01 00:11:07 | 2167 | 199 | Wabash Ave &amp; Grand Ave              |  84 | Milwaukee Ave &amp; Grand Ave      | Subscriber |\n",
       "| 21742444 | 2019-01-01 00:08:13 | 2019-01-01 00:15:34 | 4386 |  44 | State St &amp; Randolph St              | 624 | Dearborn St &amp; Van Buren St (*) | Subscriber |\n",
       "| 21742445 | 2019-01-01 00:13:23 | 2019-01-01 00:27:12 | 1524 |  15 | Racine Ave &amp; 18th St                | 644 | Western Ave &amp; Fillmore St (*)  | Subscriber |\n",
       "| 21742446 | 2019-01-01 00:13:45 | 2019-01-01 00:43:28 | 252  | 123 | California Ave &amp; Milwaukee Ave      | 176 | Clark St &amp; Elm St              | Subscriber |\n",
       "| 21742447 | 2019-01-01 00:14:52 | 2019-01-01 00:20:56 | 1170 | 173 | Mies van der Rohe Way &amp; Chicago Ave |  35 | Streeter Dr &amp; Grand Ave        | Subscriber |\n",
       "| 21742448 | 2019-01-01 00:15:33 | 2019-01-01 00:19:09 | 2437 |  98 | LaSalle St &amp; Washington St          |  49 | Dearborn St &amp; Monroe St        | Subscriber |\n",
       "\n"
      ],
      "text/plain": [
       "  ride_id  started_at          ended_at            rideable_type\n",
       "1 21742443 2019-01-01 00:04:37 2019-01-01 00:11:07 2167         \n",
       "2 21742444 2019-01-01 00:08:13 2019-01-01 00:15:34 4386         \n",
       "3 21742445 2019-01-01 00:13:23 2019-01-01 00:27:12 1524         \n",
       "4 21742446 2019-01-01 00:13:45 2019-01-01 00:43:28 252          \n",
       "5 21742447 2019-01-01 00:14:52 2019-01-01 00:20:56 1170         \n",
       "6 21742448 2019-01-01 00:15:33 2019-01-01 00:19:09 2437         \n",
       "  start_station_id start_station_name                  end_station_id\n",
       "1 199              Wabash Ave & Grand Ave               84           \n",
       "2  44              State St & Randolph St              624           \n",
       "3  15              Racine Ave & 18th St                644           \n",
       "4 123              California Ave & Milwaukee Ave      176           \n",
       "5 173              Mies van der Rohe Way & Chicago Ave  35           \n",
       "6  98              LaSalle St & Washington St           49           \n",
       "  end_station_name               member_casual\n",
       "1 Milwaukee Ave & Grand Ave      Subscriber   \n",
       "2 Dearborn St & Van Buren St (*) Subscriber   \n",
       "3 Western Ave & Fillmore St (*)  Subscriber   \n",
       "4 Clark St & Elm St              Subscriber   \n",
       "5 Streeter Dr & Grand Ave        Subscriber   \n",
       "6 Dearborn St & Monroe St        Subscriber   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "27f585e5",
   "metadata": {
    "papermill": {
     "duration": 0.017767,
     "end_time": "2024-06-25T09:56:43.827981",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.810214",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* See the last 6 rows of data frame"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "ca436b14",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:43.868094Z",
     "iopub.status.busy": "2024-06-25T09:56:43.866339Z",
     "iopub.status.idle": "2024-06-25T09:56:43.914265Z",
     "shell.execute_reply": "2024-06-25T09:56:43.912117Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.071411,
     "end_time": "2024-06-25T09:56:43.917680",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.846269",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>ride_id</th><th scope=col>started_at</th><th scope=col>ended_at</th><th scope=col>rideable_type</th><th scope=col>start_station_id</th><th scope=col>start_station_name</th><th scope=col>end_station_id</th><th scope=col>end_station_name</th><th scope=col>member_casual</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>6F4D221BDDFD943F</td><td>2020-03-10 10:40:27</td><td>2020-03-10 10:40:29</td><td>docked_bike</td><td>675</td><td>HQ QR                    </td><td>675</td><td>HQ QR                       </td><td>casual</td></tr>\n",
       "\t<tr><td>ADDAA33CEBCAE733</td><td>2020-03-10 10:40:06</td><td>2020-03-10 10:40:07</td><td>docked_bike</td><td>675</td><td>HQ QR                    </td><td>675</td><td>HQ QR                       </td><td>casual</td></tr>\n",
       "\t<tr><td>82B10FA3994BC66A</td><td>2020-03-07 15:25:55</td><td>2020-03-07 16:14:03</td><td>docked_bike</td><td>161</td><td><span style=white-space:pre-wrap>Rush St &amp; Superior St    </span></td><td>240</td><td>Sheridan Rd &amp; Irving Park Rd</td><td>member</td></tr>\n",
       "\t<tr><td>AA0D5AAA0B59C8AA</td><td>2020-03-01 13:12:38</td><td>2020-03-01 13:38:29</td><td>docked_bike</td><td>141</td><td><span style=white-space:pre-wrap>Clark St &amp; Lincoln Ave   </span></td><td>210</td><td><span style=white-space:pre-wrap>Ashland Ave &amp; Division St   </span></td><td>casual</td></tr>\n",
       "\t<tr><td>3296360A7BC20FB8</td><td>2020-03-07 18:02:45</td><td>2020-03-07 18:13:18</td><td>docked_bike</td><td>672</td><td>Franklin St &amp; Illinois St</td><td>264</td><td>Stetson Ave &amp; South Water St</td><td>member</td></tr>\n",
       "\t<tr><td>064EC7698E4FF9B3</td><td>2020-03-08 13:03:57</td><td>2020-03-08 13:32:27</td><td>docked_bike</td><td>110</td><td><span style=white-space:pre-wrap>Dearborn St &amp; Erie St    </span></td><td> 85</td><td><span style=white-space:pre-wrap>Michigan Ave &amp; Oak St       </span></td><td>casual</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " ride\\_id & started\\_at & ended\\_at & rideable\\_type & start\\_station\\_id & start\\_station\\_name & end\\_station\\_id & end\\_station\\_name & member\\_casual\\\\\n",
       " <chr> & <dttm> & <dttm> & <chr> & <dbl> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t 6F4D221BDDFD943F & 2020-03-10 10:40:27 & 2020-03-10 10:40:29 & docked\\_bike & 675 & HQ QR                     & 675 & HQ QR                        & casual\\\\\n",
       "\t ADDAA33CEBCAE733 & 2020-03-10 10:40:06 & 2020-03-10 10:40:07 & docked\\_bike & 675 & HQ QR                     & 675 & HQ QR                        & casual\\\\\n",
       "\t 82B10FA3994BC66A & 2020-03-07 15:25:55 & 2020-03-07 16:14:03 & docked\\_bike & 161 & Rush St \\& Superior St     & 240 & Sheridan Rd \\& Irving Park Rd & member\\\\\n",
       "\t AA0D5AAA0B59C8AA & 2020-03-01 13:12:38 & 2020-03-01 13:38:29 & docked\\_bike & 141 & Clark St \\& Lincoln Ave    & 210 & Ashland Ave \\& Division St    & casual\\\\\n",
       "\t 3296360A7BC20FB8 & 2020-03-07 18:02:45 & 2020-03-07 18:13:18 & docked\\_bike & 672 & Franklin St \\& Illinois St & 264 & Stetson Ave \\& South Water St & member\\\\\n",
       "\t 064EC7698E4FF9B3 & 2020-03-08 13:03:57 & 2020-03-08 13:32:27 & docked\\_bike & 110 & Dearborn St \\& Erie St     &  85 & Michigan Ave \\& Oak St        & casual\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 9\n",
       "\n",
       "| ride_id &lt;chr&gt; | started_at &lt;dttm&gt; | ended_at &lt;dttm&gt; | rideable_type &lt;chr&gt; | start_station_id &lt;dbl&gt; | start_station_name &lt;chr&gt; | end_station_id &lt;dbl&gt; | end_station_name &lt;chr&gt; | member_casual &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| 6F4D221BDDFD943F | 2020-03-10 10:40:27 | 2020-03-10 10:40:29 | docked_bike | 675 | HQ QR                     | 675 | HQ QR                        | casual |\n",
       "| ADDAA33CEBCAE733 | 2020-03-10 10:40:06 | 2020-03-10 10:40:07 | docked_bike | 675 | HQ QR                     | 675 | HQ QR                        | casual |\n",
       "| 82B10FA3994BC66A | 2020-03-07 15:25:55 | 2020-03-07 16:14:03 | docked_bike | 161 | Rush St &amp; Superior St     | 240 | Sheridan Rd &amp; Irving Park Rd | member |\n",
       "| AA0D5AAA0B59C8AA | 2020-03-01 13:12:38 | 2020-03-01 13:38:29 | docked_bike | 141 | Clark St &amp; Lincoln Ave    | 210 | Ashland Ave &amp; Division St    | casual |\n",
       "| 3296360A7BC20FB8 | 2020-03-07 18:02:45 | 2020-03-07 18:13:18 | docked_bike | 672 | Franklin St &amp; Illinois St | 264 | Stetson Ave &amp; South Water St | member |\n",
       "| 064EC7698E4FF9B3 | 2020-03-08 13:03:57 | 2020-03-08 13:32:27 | docked_bike | 110 | Dearborn St &amp; Erie St     |  85 | Michigan Ave &amp; Oak St        | casual |\n",
       "\n"
      ],
      "text/plain": [
       "  ride_id          started_at          ended_at            rideable_type\n",
       "1 6F4D221BDDFD943F 2020-03-10 10:40:27 2020-03-10 10:40:29 docked_bike  \n",
       "2 ADDAA33CEBCAE733 2020-03-10 10:40:06 2020-03-10 10:40:07 docked_bike  \n",
       "3 82B10FA3994BC66A 2020-03-07 15:25:55 2020-03-07 16:14:03 docked_bike  \n",
       "4 AA0D5AAA0B59C8AA 2020-03-01 13:12:38 2020-03-01 13:38:29 docked_bike  \n",
       "5 3296360A7BC20FB8 2020-03-07 18:02:45 2020-03-07 18:13:18 docked_bike  \n",
       "6 064EC7698E4FF9B3 2020-03-08 13:03:57 2020-03-08 13:32:27 docked_bike  \n",
       "  start_station_id start_station_name        end_station_id\n",
       "1 675              HQ QR                     675           \n",
       "2 675              HQ QR                     675           \n",
       "3 161              Rush St & Superior St     240           \n",
       "4 141              Clark St & Lincoln Ave    210           \n",
       "5 672              Franklin St & Illinois St 264           \n",
       "6 110              Dearborn St & Erie St      85           \n",
       "  end_station_name             member_casual\n",
       "1 HQ QR                        casual       \n",
       "2 HQ QR                        casual       \n",
       "3 Sheridan Rd & Irving Park Rd member       \n",
       "4 Ashland Ave & Division St    casual       \n",
       "5 Stetson Ave & South Water St member       \n",
       "6 Michigan Ave & Oak St        casual       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "tail(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "950846fd",
   "metadata": {
    "papermill": {
     "duration": 0.017908,
     "end_time": "2024-06-25T09:56:43.954134",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.936226",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* See list of columns and data types (numeric, character, etc)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "4be621b5",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:43.994718Z",
     "iopub.status.busy": "2024-06-25T09:56:43.992732Z",
     "iopub.status.idle": "2024-06-25T09:56:44.036095Z",
     "shell.execute_reply": "2024-06-25T09:56:44.033644Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.066614,
     "end_time": "2024-06-25T09:56:44.039056",
     "exception": false,
     "start_time": "2024-06-25T09:56:43.972442",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "tibble [791,956 × 9] (S3: tbl_df/tbl/data.frame)\n",
      " $ ride_id           : chr [1:791956] \"21742443\" \"21742444\" \"21742445\" \"21742446\" ...\n",
      " $ started_at        : POSIXct[1:791956], format: \"2019-01-01 00:04:37\" \"2019-01-01 00:08:13\" ...\n",
      " $ ended_at          : POSIXct[1:791956], format: \"2019-01-01 00:11:07\" \"2019-01-01 00:15:34\" ...\n",
      " $ rideable_type     : chr [1:791956] \"2167\" \"4386\" \"1524\" \"252\" ...\n",
      " $ start_station_id  : num [1:791956] 199 44 15 123 173 98 98 211 150 268 ...\n",
      " $ start_station_name: chr [1:791956] \"Wabash Ave & Grand Ave\" \"State St & Randolph St\" \"Racine Ave & 18th St\" \"California Ave & Milwaukee Ave\" ...\n",
      " $ end_station_id    : num [1:791956] 84 624 644 176 35 49 49 142 148 141 ...\n",
      " $ end_station_name  : chr [1:791956] \"Milwaukee Ave & Grand Ave\" \"Dearborn St & Van Buren St (*)\" \"Western Ave & Fillmore St (*)\" \"Clark St & Elm St\" ...\n",
      " $ member_casual     : chr [1:791956] \"Subscriber\" \"Subscriber\" \"Subscriber\" \"Subscriber\" ...\n"
     ]
    }
   ],
   "source": [
    "str(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "71d46306",
   "metadata": {
    "papermill": {
     "duration": 0.018241,
     "end_time": "2024-06-25T09:56:44.075618",
     "exception": false,
     "start_time": "2024-06-25T09:56:44.057377",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Statistical summary of data. Mainly for numerics"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "bb533159",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:44.117863Z",
     "iopub.status.busy": "2024-06-25T09:56:44.115940Z",
     "iopub.status.idle": "2024-06-25T09:56:45.820948Z",
     "shell.execute_reply": "2024-06-25T09:56:45.818663Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 1.729095,
     "end_time": "2024-06-25T09:56:45.824015",
     "exception": false,
     "start_time": "2024-06-25T09:56:44.094920",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   ride_id            started_at                     ended_at                  \n",
       " Length:791956      Min.   :2019-01-01 00:04:37   Min.   :2019-01-01 00:11:07  \n",
       " Class :character   1st Qu.:2019-02-28 17:04:04   1st Qu.:2019-02-28 17:15:58  \n",
       " Mode  :character   Median :2020-01-07 12:48:50   Median :2020-01-07 13:02:50  \n",
       "                    Mean   :2019-09-01 11:58:08   Mean   :2019-09-01 12:17:52  \n",
       "                    3rd Qu.:2020-02-19 19:31:54   3rd Qu.:2020-02-19 19:51:54  \n",
       "                    Max.   :2020-03-31 23:51:34   Max.   :2020-05-19 20:10:34  \n",
       "                                                                               \n",
       " rideable_type      start_station_id start_station_name end_station_id \n",
       " Length:791956      Min.   :  2.0    Length:791956      Min.   :  2.0  \n",
       " Class :character   1st Qu.: 77.0    Class :character   1st Qu.: 77.0  \n",
       " Mode  :character   Median :174.0    Mode  :character   Median :174.0  \n",
       "                    Mean   :204.4                       Mean   :204.4  \n",
       "                    3rd Qu.:291.0                       3rd Qu.:291.0  \n",
       "                    Max.   :675.0                       Max.   :675.0  \n",
       "                                                        NA's   :1      \n",
       " end_station_name   member_casual     \n",
       " Length:791956      Length:791956     \n",
       " Class :character   Class :character  \n",
       " Mode  :character   Mode  :character  \n",
       "                                      \n",
       "                                      \n",
       "                                      \n",
       "                                      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "062e612a",
   "metadata": {
    "papermill": {
     "duration": 0.018703,
     "end_time": "2024-06-25T09:56:45.861157",
     "exception": false,
     "start_time": "2024-06-25T09:56:45.842454",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**There are a few problems we will need to fix:**\n",
    "(1) In the __member_casual__ column, there are two names for members ( __Member__ and __Subscriber__) and two names for casual riders ( __Customer__ and __Casual__). We will need to consolidate that from four to two labels.\n",
    "\n",
    "(2) The data can only be aggregated at the ride-level, which is too granular. We will want to add some additional columns of data such as day, month, year, that provide additional opportunities to aggregate the data.\n",
    "\n",
    "(3) We will want to add a calculated field for length of ride since the __Q1_2020__ data did not have the __trip_duration__ column. We will add __ride_length__ to the entire data frame for consistency.\n",
    "\n",
    "There are some rides where __trip_duration__ shows up as negative, including several hundred rides where Divvy took bikes out of circulation for Quality Control reasons. We will want to delete these rides.\n",
    "\n",
    "**Solution to problem**\n",
    "(1) In the __member_casual__ column, replace __Subscriber__ with __Member__ and __Customer__ with __Casual__.\n",
    "\n",
    "(2) Before 2020, Divvy used different labels for these two types of riders ... we will want to make our data frame consistent with their current nomenclature\n",
    "\n",
    "* Begin by seeing how many observations fall under each usertype"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "40675f46",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:45.901285Z",
     "iopub.status.busy": "2024-06-25T09:56:45.899694Z",
     "iopub.status.idle": "2024-06-25T09:56:46.023156Z",
     "shell.execute_reply": "2024-06-25T09:56:46.021396Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.146065,
     "end_time": "2024-06-25T09:56:46.025490",
     "exception": false,
     "start_time": "2024-06-25T09:56:45.879425",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "    casual   Customer     member Subscriber \n",
       "     48480      23163     378407     341906 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "table(all_trips$member_casual)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0483e6e6",
   "metadata": {
    "papermill": {
     "duration": 0.018493,
     "end_time": "2024-06-25T09:56:46.062296",
     "exception": false,
     "start_time": "2024-06-25T09:56:46.043803",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Reassign 2019 values to 2020 values"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "13696ec5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:46.102612Z",
     "iopub.status.busy": "2024-06-25T09:56:46.101067Z",
     "iopub.status.idle": "2024-06-25T09:56:46.257065Z",
     "shell.execute_reply": "2024-06-25T09:56:46.255208Z"
    },
    "papermill": {
     "duration": 0.178861,
     "end_time": "2024-06-25T09:56:46.259620",
     "exception": false,
     "start_time": "2024-06-25T09:56:46.080759",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips <- all_trips %>% \n",
    "  mutate(member_casual = recode(member_casual\n",
    "                                ,\"Subscriber\" = \"member\"\n",
    "                                ,\"Customer\" = \"casual\"))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "dc059275",
   "metadata": {
    "papermill": {
     "duration": 0.019344,
     "end_time": "2024-06-25T09:56:46.297446",
     "exception": false,
     "start_time": "2024-06-25T09:56:46.278102",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Check to make sure the proper number of observations were reassigned"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "8ca5fdd6",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:46.342782Z",
     "iopub.status.busy": "2024-06-25T09:56:46.341165Z",
     "iopub.status.idle": "2024-06-25T09:56:46.401075Z",
     "shell.execute_reply": "2024-06-25T09:56:46.398874Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.087057,
     "end_time": "2024-06-25T09:56:46.403574",
     "exception": false,
     "start_time": "2024-06-25T09:56:46.316517",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "casual member \n",
       " 71643 720313 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "table(all_trips$member_casual)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d30defe1",
   "metadata": {
    "papermill": {
     "duration": 0.023181,
     "end_time": "2024-06-25T09:56:46.445280",
     "exception": false,
     "start_time": "2024-06-25T09:56:46.422099",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Add columns that list the date, month, day, and year of each ride.\n",
    "This will allow us to aggregate ride data for each month, day, or year ... before completing these operations we could only aggregate at the ride level"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "450d3c85",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:46.502876Z",
     "iopub.status.busy": "2024-06-25T09:56:46.500413Z",
     "iopub.status.idle": "2024-06-25T09:56:46.527774Z",
     "shell.execute_reply": "2024-06-25T09:56:46.525858Z"
    },
    "papermill": {
     "duration": 0.057528,
     "end_time": "2024-06-25T09:56:46.530426",
     "exception": false,
     "start_time": "2024-06-25T09:56:46.472898",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips$date <- as.Date(all_trips$started_at)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0b13a030",
   "metadata": {
    "papermill": {
     "duration": 0.019537,
     "end_time": "2024-06-25T09:56:46.568553",
     "exception": false,
     "start_time": "2024-06-25T09:56:46.549016",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "The default format is yyyy-mm-dd"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "a6eaa416",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:46.609382Z",
     "iopub.status.busy": "2024-06-25T09:56:46.607835Z",
     "iopub.status.idle": "2024-06-25T09:56:46.916579Z",
     "shell.execute_reply": "2024-06-25T09:56:46.914735Z"
    },
    "papermill": {
     "duration": 0.332124,
     "end_time": "2024-06-25T09:56:46.919133",
     "exception": false,
     "start_time": "2024-06-25T09:56:46.587009",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips$month <- format(as.Date(all_trips$date), \"%b\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "3ec57d70",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:46.961295Z",
     "iopub.status.busy": "2024-06-25T09:56:46.959693Z",
     "iopub.status.idle": "2024-06-25T09:56:47.325115Z",
     "shell.execute_reply": "2024-06-25T09:56:47.323279Z"
    },
    "papermill": {
     "duration": 0.389847,
     "end_time": "2024-06-25T09:56:47.328233",
     "exception": false,
     "start_time": "2024-06-25T09:56:46.938386",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips$day <- format(as.Date(all_trips$date), \"%d\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "78999ba0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:47.370403Z",
     "iopub.status.busy": "2024-06-25T09:56:47.368832Z",
     "iopub.status.idle": "2024-06-25T09:56:47.896675Z",
     "shell.execute_reply": "2024-06-25T09:56:47.894853Z"
    },
    "papermill": {
     "duration": 0.551995,
     "end_time": "2024-06-25T09:56:47.899232",
     "exception": false,
     "start_time": "2024-06-25T09:56:47.347237",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips$year <- format(as.Date(all_trips$date), \"%Y\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "id": "20a470eb",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:47.940513Z",
     "iopub.status.busy": "2024-06-25T09:56:47.938941Z",
     "iopub.status.idle": "2024-06-25T09:56:48.233802Z",
     "shell.execute_reply": "2024-06-25T09:56:48.231938Z"
    },
    "papermill": {
     "duration": 0.318065,
     "end_time": "2024-06-25T09:56:48.236324",
     "exception": false,
     "start_time": "2024-06-25T09:56:47.918259",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips$day_of_week <- format(as.Date(all_trips$date), \"%A\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "3372db3b",
   "metadata": {
    "papermill": {
     "duration": 0.018631,
     "end_time": "2024-06-25T09:56:48.273725",
     "exception": false,
     "start_time": "2024-06-25T09:56:48.255094",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Add a __ride_length__ calculation to all_trips(in seconds)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "id": "45560a3a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:48.314449Z",
     "iopub.status.busy": "2024-06-25T09:56:48.312793Z",
     "iopub.status.idle": "2024-06-25T09:56:48.345119Z",
     "shell.execute_reply": "2024-06-25T09:56:48.343235Z"
    },
    "papermill": {
     "duration": 0.055341,
     "end_time": "2024-06-25T09:56:48.347568",
     "exception": false,
     "start_time": "2024-06-25T09:56:48.292227",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips$ride_length <- difftime(all_trips$ended_at, all_trips$started_at)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b3a7d9c7",
   "metadata": {
    "papermill": {
     "duration": 0.019413,
     "end_time": "2024-06-25T09:56:48.385961",
     "exception": false,
     "start_time": "2024-06-25T09:56:48.366548",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Inspect the structure of the columns"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 27,
   "id": "d95edffd",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:48.427386Z",
     "iopub.status.busy": "2024-06-25T09:56:48.425774Z",
     "iopub.status.idle": "2024-06-25T09:56:48.472010Z",
     "shell.execute_reply": "2024-06-25T09:56:48.469891Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.069505,
     "end_time": "2024-06-25T09:56:48.474429",
     "exception": false,
     "start_time": "2024-06-25T09:56:48.404924",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "tibble [791,956 × 15] (S3: tbl_df/tbl/data.frame)\n",
      " $ ride_id           : chr [1:791956] \"21742443\" \"21742444\" \"21742445\" \"21742446\" ...\n",
      " $ started_at        : POSIXct[1:791956], format: \"2019-01-01 00:04:37\" \"2019-01-01 00:08:13\" ...\n",
      " $ ended_at          : POSIXct[1:791956], format: \"2019-01-01 00:11:07\" \"2019-01-01 00:15:34\" ...\n",
      " $ rideable_type     : chr [1:791956] \"2167\" \"4386\" \"1524\" \"252\" ...\n",
      " $ start_station_id  : num [1:791956] 199 44 15 123 173 98 98 211 150 268 ...\n",
      " $ start_station_name: chr [1:791956] \"Wabash Ave & Grand Ave\" \"State St & Randolph St\" \"Racine Ave & 18th St\" \"California Ave & Milwaukee Ave\" ...\n",
      " $ end_station_id    : num [1:791956] 84 624 644 176 35 49 49 142 148 141 ...\n",
      " $ end_station_name  : chr [1:791956] \"Milwaukee Ave & Grand Ave\" \"Dearborn St & Van Buren St (*)\" \"Western Ave & Fillmore St (*)\" \"Clark St & Elm St\" ...\n",
      " $ member_casual     : chr [1:791956] \"member\" \"member\" \"member\" \"member\" ...\n",
      " $ date              : Date[1:791956], format: \"2019-01-01\" \"2019-01-01\" ...\n",
      " $ month             : chr [1:791956] \"Jan\" \"Jan\" \"Jan\" \"Jan\" ...\n",
      " $ day               : chr [1:791956] \"01\" \"01\" \"01\" \"01\" ...\n",
      " $ year              : chr [1:791956] \"2019\" \"2019\" \"2019\" \"2019\" ...\n",
      " $ day_of_week       : chr [1:791956] \"Tuesday\" \"Tuesday\" \"Tuesday\" \"Tuesday\" ...\n",
      " $ ride_length       : 'difftime' num [1:791956] 390 441 829 1783 ...\n",
      "  ..- attr(*, \"units\")= chr \"secs\"\n"
     ]
    }
   ],
   "source": [
    "str(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "2e2dcb2e",
   "metadata": {
    "papermill": {
     "duration": 0.019086,
     "end_time": "2024-06-25T09:56:48.512407",
     "exception": false,
     "start_time": "2024-06-25T09:56:48.493321",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Convert __ride_length__ from difftime to numeric so we can run calculations on the data"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 28,
   "id": "ec133bed",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:48.554308Z",
     "iopub.status.busy": "2024-06-25T09:56:48.552741Z",
     "iopub.status.idle": "2024-06-25T09:56:48.573590Z",
     "shell.execute_reply": "2024-06-25T09:56:48.571723Z"
    },
    "papermill": {
     "duration": 0.044907,
     "end_time": "2024-06-25T09:56:48.576136",
     "exception": false,
     "start_time": "2024-06-25T09:56:48.531229",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips$ride_length <- as.numeric(all_trips$ride_length)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "39ea4b44",
   "metadata": {
    "papermill": {
     "duration": 0.01875,
     "end_time": "2024-06-25T09:56:48.613722",
     "exception": false,
     "start_time": "2024-06-25T09:56:48.594972",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Remove \"bad\" data\n",
    "The data frame includes a few hundred entries when bikes were taken out of docks and checked for quality by Divvy or ride_length was negative"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 29,
   "id": "ab4c088e",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:48.655029Z",
     "iopub.status.busy": "2024-06-25T09:56:48.653398Z",
     "iopub.status.idle": "2024-06-25T09:56:48.929995Z",
     "shell.execute_reply": "2024-06-25T09:56:48.928190Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.300142,
     "end_time": "2024-06-25T09:56:48.932629",
     "exception": false,
     "start_time": "2024-06-25T09:56:48.632487",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 210 × 15</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>ride_id</th><th scope=col>started_at</th><th scope=col>ended_at</th><th scope=col>rideable_type</th><th scope=col>start_station_id</th><th scope=col>start_station_name</th><th scope=col>end_station_id</th><th scope=col>end_station_name</th><th scope=col>member_casual</th><th scope=col>date</th><th scope=col>month</th><th scope=col>day</th><th scope=col>year</th><th scope=col>day_of_week</th><th scope=col>ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>23EF1DCC9FCA40BA</td><td>2020-02-28 11:34:40</td><td>2020-02-28 11:34:40</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-02-28</td><td>Feb</td><td>28</td><td>2020</td><td>Friday   </td><td>  0</td></tr>\n",
       "\t<tr><td>9461DFF13D8BA8AD</td><td>2020-02-28 10:09:43</td><td>2020-02-28 10:09:42</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-02-28</td><td>Feb</td><td>28</td><td>2020</td><td>Friday   </td><td> -1</td></tr>\n",
       "\t<tr><td>86163D9676BBBE62</td><td>2020-02-26 14:41:16</td><td>2020-02-26 14:41:16</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-02-26</td><td>Feb</td><td>26</td><td>2020</td><td>Wednesday</td><td>  0</td></tr>\n",
       "\t<tr><td>836931C569802344</td><td>2020-02-27 09:56:47</td><td>2020-02-27 09:56:47</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-02-27</td><td>Feb</td><td>27</td><td>2020</td><td>Thursday </td><td>  0</td></tr>\n",
       "\t<tr><td>07CD3CBC94106B37</td><td>2020-02-28 10:02:30</td><td>2020-02-28 10:02:30</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-02-28</td><td>Feb</td><td>28</td><td>2020</td><td>Friday   </td><td>  0</td></tr>\n",
       "\t<tr><td>83D849E5C5716FA3</td><td>2020-02-28 10:39:01</td><td>2020-02-28 10:39:01</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-02-28</td><td>Feb</td><td>28</td><td>2020</td><td>Friday   </td><td>  0</td></tr>\n",
       "\t<tr><td>4BF5C10795152574</td><td>2020-02-26 15:11:49</td><td>2020-02-26 15:11:49</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-02-26</td><td>Feb</td><td>26</td><td>2020</td><td>Wednesday</td><td>  0</td></tr>\n",
       "\t<tr><td>6EB2E392C75D5246</td><td>2020-02-26 12:49:59</td><td>2020-02-26 12:49:59</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-02-26</td><td>Feb</td><td>26</td><td>2020</td><td>Wednesday</td><td>  0</td></tr>\n",
       "\t<tr><td>8B167ABFC026622D</td><td>2020-02-26 12:50:52</td><td>2020-02-26 12:50:52</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-02-26</td><td>Feb</td><td>26</td><td>2020</td><td>Wednesday</td><td>  0</td></tr>\n",
       "\t<tr><td>4CCD45F6BA577FF3</td><td>2020-02-26 15:06:47</td><td>2020-02-26 15:06:47</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-02-26</td><td>Feb</td><td>26</td><td>2020</td><td>Wednesday</td><td>  0</td></tr>\n",
       "\t<tr><td>794264334D168D05</td><td>2020-03-18 11:43:09</td><td>2020-03-18 11:42:58</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>-11</td></tr>\n",
       "\t<tr><td>395F2D12B8A335B8</td><td>2020-03-18 10:49:33</td><td>2020-03-18 10:49:33</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>  0</td></tr>\n",
       "\t<tr><td>3CC0D87545CE223B</td><td>2020-03-19 09:43:05</td><td>2020-03-19 09:42:51</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-19</td><td>Mar</td><td>19</td><td>2020</td><td>Thursday </td><td>-14</td></tr>\n",
       "\t<tr><td>5D5E9B7782A62F66</td><td>2020-03-19 09:44:04</td><td>2020-03-19 09:44:04</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-19</td><td>Mar</td><td>19</td><td>2020</td><td>Thursday </td><td>  0</td></tr>\n",
       "\t<tr><td>32CAF6E2E7AB67CE</td><td>2020-03-12 10:00:46</td><td>2020-03-12 10:00:36</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-12</td><td>Mar</td><td>12</td><td>2020</td><td>Thursday </td><td>-10</td></tr>\n",
       "\t<tr><td>88D98921A2382D2F</td><td>2020-03-04 11:44:56</td><td>2020-03-04 11:44:56</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-04</td><td>Mar</td><td>04</td><td>2020</td><td>Wednesday</td><td>  0</td></tr>\n",
       "\t<tr><td>13BCB74BAFDADB21</td><td>2020-03-27 14:59:51</td><td>2020-03-27 14:58:18</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-27</td><td>Mar</td><td>27</td><td>2020</td><td>Friday   </td><td>-93</td></tr>\n",
       "\t<tr><td>4EF350E51E6037AF</td><td>2020-03-19 09:37:17</td><td>2020-03-19 09:37:04</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-19</td><td>Mar</td><td>19</td><td>2020</td><td>Thursday </td><td>-13</td></tr>\n",
       "\t<tr><td>D96C52A466344F56</td><td>2020-03-12 09:27:31</td><td>2020-03-12 09:27:20</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-12</td><td>Mar</td><td>12</td><td>2020</td><td>Thursday </td><td>-11</td></tr>\n",
       "\t<tr><td>A7491869619B539E</td><td>2020-03-17 12:22:18</td><td>2020-03-17 12:22:07</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-17</td><td>Mar</td><td>17</td><td>2020</td><td>Tuesday  </td><td>-11</td></tr>\n",
       "\t<tr><td>50F979A1289A1621</td><td>2020-03-02 09:27:10</td><td>2020-03-02 09:27:10</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-02</td><td>Mar</td><td>02</td><td>2020</td><td>Monday   </td><td>  0</td></tr>\n",
       "\t<tr><td>DC6D24FB727542F1</td><td>2020-03-20 09:00:53</td><td>2020-03-20 09:00:40</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-20</td><td>Mar</td><td>20</td><td>2020</td><td>Friday   </td><td>-13</td></tr>\n",
       "\t<tr><td>7DC201C78AA1DACA</td><td>2020-03-02 12:29:37</td><td>2020-03-02 12:29:37</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-02</td><td>Mar</td><td>02</td><td>2020</td><td>Monday   </td><td>  0</td></tr>\n",
       "\t<tr><td>C95725BA7EBD1498</td><td>2020-03-18 12:24:02</td><td>2020-03-18 12:23:51</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>-11</td></tr>\n",
       "\t<tr><td>5C83D9F28FBE25B3</td><td>2020-03-16 14:03:10</td><td>2020-03-16 14:03:10</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-16</td><td>Mar</td><td>16</td><td>2020</td><td>Monday   </td><td>  0</td></tr>\n",
       "\t<tr><td>86F9E9C2AEAAF5A1</td><td>2020-03-12 09:39:52</td><td>2020-03-12 09:39:52</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-12</td><td>Mar</td><td>12</td><td>2020</td><td>Thursday </td><td>  0</td></tr>\n",
       "\t<tr><td>22B7786E02DB39AD</td><td>2020-03-20 09:13:26</td><td>2020-03-20 09:13:12</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-20</td><td>Mar</td><td>20</td><td>2020</td><td>Friday   </td><td>-14</td></tr>\n",
       "\t<tr><td>F46A4E6332A8C4CB</td><td>2020-03-02 09:27:10</td><td>2020-03-02 09:27:10</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-02</td><td>Mar</td><td>02</td><td>2020</td><td>Monday   </td><td>  0</td></tr>\n",
       "\t<tr><td>8151A1ECCD4115C9</td><td>2020-03-20 10:01:22</td><td>2020-03-20 10:01:10</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-20</td><td>Mar</td><td>20</td><td>2020</td><td>Friday   </td><td>-12</td></tr>\n",
       "\t<tr><td>0CFB4DBF0FDAD733</td><td>2020-03-18 10:55:07</td><td>2020-03-18 10:54:55</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>-12</td></tr>\n",
       "\t<tr><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><td>5FC950EA4F49BD1B</td><td>2020-03-02 10:02:13</td><td>2020-03-02 10:02:13</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-02</td><td>Mar</td><td>02</td><td>2020</td><td>Monday   </td><td>  0</td></tr>\n",
       "\t<tr><td>E61408AB2A41D15D</td><td>2020-03-16 11:41:23</td><td>2020-03-16 11:41:11</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-16</td><td>Mar</td><td>16</td><td>2020</td><td>Monday   </td><td>-12</td></tr>\n",
       "\t<tr><td>2218A4D928820E6E</td><td>2020-03-18 09:37:11</td><td>2020-03-18 09:36:59</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>-12</td></tr>\n",
       "\t<tr><td>B0565BEDAF8D721F</td><td>2020-03-18 11:30:34</td><td>2020-03-18 11:30:12</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>-22</td></tr>\n",
       "\t<tr><td>6E739A980BFEA8F4</td><td>2020-03-09 13:24:41</td><td>2020-03-09 13:24:41</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-09</td><td>Mar</td><td>09</td><td>2020</td><td>Monday   </td><td>  0</td></tr>\n",
       "\t<tr><td>22CDAB1855EFB928</td><td>2020-03-16 11:43:49</td><td>2020-03-16 11:43:38</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-16</td><td>Mar</td><td>16</td><td>2020</td><td>Monday   </td><td>-11</td></tr>\n",
       "\t<tr><td>4B1478D45C94AB00</td><td>2020-03-18 11:34:05</td><td>2020-03-18 11:33:53</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>-12</td></tr>\n",
       "\t<tr><td>992E918554162BAF</td><td>2020-03-02 14:01:31</td><td>2020-03-02 14:01:31</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-02</td><td>Mar</td><td>02</td><td>2020</td><td>Monday   </td><td>  0</td></tr>\n",
       "\t<tr><td>5285E8EBDF67F7EB</td><td>2020-03-12 09:16:04</td><td>2020-03-12 09:15:54</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-12</td><td>Mar</td><td>12</td><td>2020</td><td>Thursday </td><td>-10</td></tr>\n",
       "\t<tr><td>2E2C3F0A1CBC11BF</td><td>2020-03-20 09:08:01</td><td>2020-03-20 09:08:01</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-20</td><td>Mar</td><td>20</td><td>2020</td><td>Friday   </td><td>  0</td></tr>\n",
       "\t<tr><td>6BB28B54D146A2A0</td><td>2020-03-19 10:37:51</td><td>2020-03-19 10:37:38</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-19</td><td>Mar</td><td>19</td><td>2020</td><td>Thursday </td><td>-13</td></tr>\n",
       "\t<tr><td>54D18287D2AA2F1C</td><td>2020-03-10 10:37:08</td><td>2020-03-10 10:37:08</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-10</td><td>Mar</td><td>10</td><td>2020</td><td>Tuesday  </td><td>  0</td></tr>\n",
       "\t<tr><td>7248AE8F5CD8BF91</td><td>2020-03-16 09:42:14</td><td>2020-03-16 09:42:03</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-16</td><td>Mar</td><td>16</td><td>2020</td><td>Monday   </td><td>-11</td></tr>\n",
       "\t<tr><td>AE7E1838C92E15CB</td><td>2020-03-18 14:31:52</td><td>2020-03-18 14:31:40</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>-12</td></tr>\n",
       "\t<tr><td>157EAA4C4A3C8D36</td><td>2020-03-16 11:23:36</td><td>2020-03-16 11:23:24</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td> NA</td><td>NA   </td><td>casual</td><td>2020-03-16</td><td>Mar</td><td>16</td><td>2020</td><td>Monday   </td><td>-12</td></tr>\n",
       "\t<tr><td>3F70F88E187745B7</td><td>2020-03-18 10:18:52</td><td>2020-03-18 10:18:52</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>  0</td></tr>\n",
       "\t<tr><td>DB6502CD28E046D7</td><td>2020-03-05 09:07:29</td><td>2020-03-05 09:07:29</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-05</td><td>Mar</td><td>05</td><td>2020</td><td>Thursday </td><td>  0</td></tr>\n",
       "\t<tr><td>3F591668748DC77B</td><td>2020-03-12 09:58:26</td><td>2020-03-12 09:58:14</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-12</td><td>Mar</td><td>12</td><td>2020</td><td>Thursday </td><td>-12</td></tr>\n",
       "\t<tr><td>CA49582758849EE5</td><td>2020-03-18 09:16:46</td><td>2020-03-18 09:16:35</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>-11</td></tr>\n",
       "\t<tr><td>A97C7A198F879C4E</td><td>2020-03-18 09:17:25</td><td>2020-03-18 09:17:25</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>  0</td></tr>\n",
       "\t<tr><td>C2F71E40D52A0660</td><td>2020-03-18 15:12:18</td><td>2020-03-18 15:12:04</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-18</td><td>Mar</td><td>18</td><td>2020</td><td>Wednesday</td><td>-14</td></tr>\n",
       "\t<tr><td>14AF5815838B9F2C</td><td>2020-03-13 08:38:14</td><td>2020-03-13 08:38:03</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-13</td><td>Mar</td><td>13</td><td>2020</td><td>Friday   </td><td>-11</td></tr>\n",
       "\t<tr><td>8C8F5D8DE7FBF8D0</td><td>2020-03-02 09:46:48</td><td>2020-03-02 09:46:48</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-02</td><td>Mar</td><td>02</td><td>2020</td><td>Monday   </td><td>  0</td></tr>\n",
       "\t<tr><td>C5BDA1DB624F3658</td><td>2020-03-19 10:04:31</td><td>2020-03-19 10:04:31</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-19</td><td>Mar</td><td>19</td><td>2020</td><td>Thursday </td><td>  0</td></tr>\n",
       "\t<tr><td>D94EF149247F3880</td><td>2020-03-19 10:24:16</td><td>2020-03-19 10:24:05</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-19</td><td>Mar</td><td>19</td><td>2020</td><td>Thursday </td><td>-11</td></tr>\n",
       "\t<tr><td>09C4B33945876A83</td><td>2020-03-10 09:54:23</td><td>2020-03-10 09:54:23</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-10</td><td>Mar</td><td>10</td><td>2020</td><td>Tuesday  </td><td>  0</td></tr>\n",
       "\t<tr><td>323CAC41316F59B2</td><td>2020-03-13 08:51:45</td><td>2020-03-13 08:51:34</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-13</td><td>Mar</td><td>13</td><td>2020</td><td>Friday   </td><td>-11</td></tr>\n",
       "\t<tr><td>476717BBABCAE518</td><td>2020-03-19 09:31:56</td><td>2020-03-19 09:31:45</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-19</td><td>Mar</td><td>19</td><td>2020</td><td>Thursday </td><td>-11</td></tr>\n",
       "\t<tr><td>F809003AA48EC0C1</td><td>2020-03-09 12:12:59</td><td>2020-03-09 12:12:59</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-09</td><td>Mar</td><td>09</td><td>2020</td><td>Monday   </td><td>  0</td></tr>\n",
       "\t<tr><td>57FF6A81E9517A6E</td><td>2020-03-16 13:42:39</td><td>2020-03-16 13:42:39</td><td>docked_bike</td><td>675</td><td>HQ QR</td><td>675</td><td>HQ QR</td><td>casual</td><td>2020-03-16</td><td>Mar</td><td>16</td><td>2020</td><td>Monday   </td><td>  0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 210 × 15\n",
       "\\begin{tabular}{lllllllllllllll}\n",
       " ride\\_id & started\\_at & ended\\_at & rideable\\_type & start\\_station\\_id & start\\_station\\_name & end\\_station\\_id & end\\_station\\_name & member\\_casual & date & month & day & year & day\\_of\\_week & ride\\_length\\\\\n",
       " <chr> & <dttm> & <dttm> & <chr> & <dbl> & <chr> & <dbl> & <chr> & <chr> & <date> & <chr> & <chr> & <chr> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 23EF1DCC9FCA40BA & 2020-02-28 11:34:40 & 2020-02-28 11:34:40 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-02-28 & Feb & 28 & 2020 & Friday    &   0\\\\\n",
       "\t 9461DFF13D8BA8AD & 2020-02-28 10:09:43 & 2020-02-28 10:09:42 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-02-28 & Feb & 28 & 2020 & Friday    &  -1\\\\\n",
       "\t 86163D9676BBBE62 & 2020-02-26 14:41:16 & 2020-02-26 14:41:16 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-02-26 & Feb & 26 & 2020 & Wednesday &   0\\\\\n",
       "\t 836931C569802344 & 2020-02-27 09:56:47 & 2020-02-27 09:56:47 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-02-27 & Feb & 27 & 2020 & Thursday  &   0\\\\\n",
       "\t 07CD3CBC94106B37 & 2020-02-28 10:02:30 & 2020-02-28 10:02:30 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-02-28 & Feb & 28 & 2020 & Friday    &   0\\\\\n",
       "\t 83D849E5C5716FA3 & 2020-02-28 10:39:01 & 2020-02-28 10:39:01 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-02-28 & Feb & 28 & 2020 & Friday    &   0\\\\\n",
       "\t 4BF5C10795152574 & 2020-02-26 15:11:49 & 2020-02-26 15:11:49 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-02-26 & Feb & 26 & 2020 & Wednesday &   0\\\\\n",
       "\t 6EB2E392C75D5246 & 2020-02-26 12:49:59 & 2020-02-26 12:49:59 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-02-26 & Feb & 26 & 2020 & Wednesday &   0\\\\\n",
       "\t 8B167ABFC026622D & 2020-02-26 12:50:52 & 2020-02-26 12:50:52 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-02-26 & Feb & 26 & 2020 & Wednesday &   0\\\\\n",
       "\t 4CCD45F6BA577FF3 & 2020-02-26 15:06:47 & 2020-02-26 15:06:47 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-02-26 & Feb & 26 & 2020 & Wednesday &   0\\\\\n",
       "\t 794264334D168D05 & 2020-03-18 11:43:09 & 2020-03-18 11:42:58 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday & -11\\\\\n",
       "\t 395F2D12B8A335B8 & 2020-03-18 10:49:33 & 2020-03-18 10:49:33 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday &   0\\\\\n",
       "\t 3CC0D87545CE223B & 2020-03-19 09:43:05 & 2020-03-19 09:42:51 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-19 & Mar & 19 & 2020 & Thursday  & -14\\\\\n",
       "\t 5D5E9B7782A62F66 & 2020-03-19 09:44:04 & 2020-03-19 09:44:04 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-19 & Mar & 19 & 2020 & Thursday  &   0\\\\\n",
       "\t 32CAF6E2E7AB67CE & 2020-03-12 10:00:46 & 2020-03-12 10:00:36 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-12 & Mar & 12 & 2020 & Thursday  & -10\\\\\n",
       "\t 88D98921A2382D2F & 2020-03-04 11:44:56 & 2020-03-04 11:44:56 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-04 & Mar & 04 & 2020 & Wednesday &   0\\\\\n",
       "\t 13BCB74BAFDADB21 & 2020-03-27 14:59:51 & 2020-03-27 14:58:18 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-27 & Mar & 27 & 2020 & Friday    & -93\\\\\n",
       "\t 4EF350E51E6037AF & 2020-03-19 09:37:17 & 2020-03-19 09:37:04 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-19 & Mar & 19 & 2020 & Thursday  & -13\\\\\n",
       "\t D96C52A466344F56 & 2020-03-12 09:27:31 & 2020-03-12 09:27:20 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-12 & Mar & 12 & 2020 & Thursday  & -11\\\\\n",
       "\t A7491869619B539E & 2020-03-17 12:22:18 & 2020-03-17 12:22:07 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-17 & Mar & 17 & 2020 & Tuesday   & -11\\\\\n",
       "\t 50F979A1289A1621 & 2020-03-02 09:27:10 & 2020-03-02 09:27:10 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-02 & Mar & 02 & 2020 & Monday    &   0\\\\\n",
       "\t DC6D24FB727542F1 & 2020-03-20 09:00:53 & 2020-03-20 09:00:40 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-20 & Mar & 20 & 2020 & Friday    & -13\\\\\n",
       "\t 7DC201C78AA1DACA & 2020-03-02 12:29:37 & 2020-03-02 12:29:37 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-02 & Mar & 02 & 2020 & Monday    &   0\\\\\n",
       "\t C95725BA7EBD1498 & 2020-03-18 12:24:02 & 2020-03-18 12:23:51 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday & -11\\\\\n",
       "\t 5C83D9F28FBE25B3 & 2020-03-16 14:03:10 & 2020-03-16 14:03:10 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-16 & Mar & 16 & 2020 & Monday    &   0\\\\\n",
       "\t 86F9E9C2AEAAF5A1 & 2020-03-12 09:39:52 & 2020-03-12 09:39:52 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-12 & Mar & 12 & 2020 & Thursday  &   0\\\\\n",
       "\t 22B7786E02DB39AD & 2020-03-20 09:13:26 & 2020-03-20 09:13:12 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-20 & Mar & 20 & 2020 & Friday    & -14\\\\\n",
       "\t F46A4E6332A8C4CB & 2020-03-02 09:27:10 & 2020-03-02 09:27:10 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-02 & Mar & 02 & 2020 & Monday    &   0\\\\\n",
       "\t 8151A1ECCD4115C9 & 2020-03-20 10:01:22 & 2020-03-20 10:01:10 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-20 & Mar & 20 & 2020 & Friday    & -12\\\\\n",
       "\t 0CFB4DBF0FDAD733 & 2020-03-18 10:55:07 & 2020-03-18 10:54:55 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday & -12\\\\\n",
       "\t ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮\\\\\n",
       "\t 5FC950EA4F49BD1B & 2020-03-02 10:02:13 & 2020-03-02 10:02:13 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-02 & Mar & 02 & 2020 & Monday    &   0\\\\\n",
       "\t E61408AB2A41D15D & 2020-03-16 11:41:23 & 2020-03-16 11:41:11 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-16 & Mar & 16 & 2020 & Monday    & -12\\\\\n",
       "\t 2218A4D928820E6E & 2020-03-18 09:37:11 & 2020-03-18 09:36:59 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday & -12\\\\\n",
       "\t B0565BEDAF8D721F & 2020-03-18 11:30:34 & 2020-03-18 11:30:12 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday & -22\\\\\n",
       "\t 6E739A980BFEA8F4 & 2020-03-09 13:24:41 & 2020-03-09 13:24:41 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-09 & Mar & 09 & 2020 & Monday    &   0\\\\\n",
       "\t 22CDAB1855EFB928 & 2020-03-16 11:43:49 & 2020-03-16 11:43:38 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-16 & Mar & 16 & 2020 & Monday    & -11\\\\\n",
       "\t 4B1478D45C94AB00 & 2020-03-18 11:34:05 & 2020-03-18 11:33:53 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday & -12\\\\\n",
       "\t 992E918554162BAF & 2020-03-02 14:01:31 & 2020-03-02 14:01:31 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-02 & Mar & 02 & 2020 & Monday    &   0\\\\\n",
       "\t 5285E8EBDF67F7EB & 2020-03-12 09:16:04 & 2020-03-12 09:15:54 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-12 & Mar & 12 & 2020 & Thursday  & -10\\\\\n",
       "\t 2E2C3F0A1CBC11BF & 2020-03-20 09:08:01 & 2020-03-20 09:08:01 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-20 & Mar & 20 & 2020 & Friday    &   0\\\\\n",
       "\t 6BB28B54D146A2A0 & 2020-03-19 10:37:51 & 2020-03-19 10:37:38 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-19 & Mar & 19 & 2020 & Thursday  & -13\\\\\n",
       "\t 54D18287D2AA2F1C & 2020-03-10 10:37:08 & 2020-03-10 10:37:08 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-10 & Mar & 10 & 2020 & Tuesday   &   0\\\\\n",
       "\t 7248AE8F5CD8BF91 & 2020-03-16 09:42:14 & 2020-03-16 09:42:03 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-16 & Mar & 16 & 2020 & Monday    & -11\\\\\n",
       "\t AE7E1838C92E15CB & 2020-03-18 14:31:52 & 2020-03-18 14:31:40 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday & -12\\\\\n",
       "\t 157EAA4C4A3C8D36 & 2020-03-16 11:23:36 & 2020-03-16 11:23:24 & docked\\_bike & 675 & HQ QR &  NA & NA    & casual & 2020-03-16 & Mar & 16 & 2020 & Monday    & -12\\\\\n",
       "\t 3F70F88E187745B7 & 2020-03-18 10:18:52 & 2020-03-18 10:18:52 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday &   0\\\\\n",
       "\t DB6502CD28E046D7 & 2020-03-05 09:07:29 & 2020-03-05 09:07:29 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-05 & Mar & 05 & 2020 & Thursday  &   0\\\\\n",
       "\t 3F591668748DC77B & 2020-03-12 09:58:26 & 2020-03-12 09:58:14 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-12 & Mar & 12 & 2020 & Thursday  & -12\\\\\n",
       "\t CA49582758849EE5 & 2020-03-18 09:16:46 & 2020-03-18 09:16:35 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday & -11\\\\\n",
       "\t A97C7A198F879C4E & 2020-03-18 09:17:25 & 2020-03-18 09:17:25 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday &   0\\\\\n",
       "\t C2F71E40D52A0660 & 2020-03-18 15:12:18 & 2020-03-18 15:12:04 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-18 & Mar & 18 & 2020 & Wednesday & -14\\\\\n",
       "\t 14AF5815838B9F2C & 2020-03-13 08:38:14 & 2020-03-13 08:38:03 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-13 & Mar & 13 & 2020 & Friday    & -11\\\\\n",
       "\t 8C8F5D8DE7FBF8D0 & 2020-03-02 09:46:48 & 2020-03-02 09:46:48 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-02 & Mar & 02 & 2020 & Monday    &   0\\\\\n",
       "\t C5BDA1DB624F3658 & 2020-03-19 10:04:31 & 2020-03-19 10:04:31 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-19 & Mar & 19 & 2020 & Thursday  &   0\\\\\n",
       "\t D94EF149247F3880 & 2020-03-19 10:24:16 & 2020-03-19 10:24:05 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-19 & Mar & 19 & 2020 & Thursday  & -11\\\\\n",
       "\t 09C4B33945876A83 & 2020-03-10 09:54:23 & 2020-03-10 09:54:23 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-10 & Mar & 10 & 2020 & Tuesday   &   0\\\\\n",
       "\t 323CAC41316F59B2 & 2020-03-13 08:51:45 & 2020-03-13 08:51:34 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-13 & Mar & 13 & 2020 & Friday    & -11\\\\\n",
       "\t 476717BBABCAE518 & 2020-03-19 09:31:56 & 2020-03-19 09:31:45 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-19 & Mar & 19 & 2020 & Thursday  & -11\\\\\n",
       "\t F809003AA48EC0C1 & 2020-03-09 12:12:59 & 2020-03-09 12:12:59 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-09 & Mar & 09 & 2020 & Monday    &   0\\\\\n",
       "\t 57FF6A81E9517A6E & 2020-03-16 13:42:39 & 2020-03-16 13:42:39 & docked\\_bike & 675 & HQ QR & 675 & HQ QR & casual & 2020-03-16 & Mar & 16 & 2020 & Monday    &   0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 210 × 15\n",
       "\n",
       "| ride_id &lt;chr&gt; | started_at &lt;dttm&gt; | ended_at &lt;dttm&gt; | rideable_type &lt;chr&gt; | start_station_id &lt;dbl&gt; | start_station_name &lt;chr&gt; | end_station_id &lt;dbl&gt; | end_station_name &lt;chr&gt; | member_casual &lt;chr&gt; | date &lt;date&gt; | month &lt;chr&gt; | day &lt;chr&gt; | year &lt;chr&gt; | day_of_week &lt;chr&gt; | ride_length &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 23EF1DCC9FCA40BA | 2020-02-28 11:34:40 | 2020-02-28 11:34:40 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-02-28 | Feb | 28 | 2020 | Friday    |   0 |\n",
       "| 9461DFF13D8BA8AD | 2020-02-28 10:09:43 | 2020-02-28 10:09:42 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-02-28 | Feb | 28 | 2020 | Friday    |  -1 |\n",
       "| 86163D9676BBBE62 | 2020-02-26 14:41:16 | 2020-02-26 14:41:16 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-02-26 | Feb | 26 | 2020 | Wednesday |   0 |\n",
       "| 836931C569802344 | 2020-02-27 09:56:47 | 2020-02-27 09:56:47 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-02-27 | Feb | 27 | 2020 | Thursday  |   0 |\n",
       "| 07CD3CBC94106B37 | 2020-02-28 10:02:30 | 2020-02-28 10:02:30 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-02-28 | Feb | 28 | 2020 | Friday    |   0 |\n",
       "| 83D849E5C5716FA3 | 2020-02-28 10:39:01 | 2020-02-28 10:39:01 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-02-28 | Feb | 28 | 2020 | Friday    |   0 |\n",
       "| 4BF5C10795152574 | 2020-02-26 15:11:49 | 2020-02-26 15:11:49 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-02-26 | Feb | 26 | 2020 | Wednesday |   0 |\n",
       "| 6EB2E392C75D5246 | 2020-02-26 12:49:59 | 2020-02-26 12:49:59 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-02-26 | Feb | 26 | 2020 | Wednesday |   0 |\n",
       "| 8B167ABFC026622D | 2020-02-26 12:50:52 | 2020-02-26 12:50:52 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-02-26 | Feb | 26 | 2020 | Wednesday |   0 |\n",
       "| 4CCD45F6BA577FF3 | 2020-02-26 15:06:47 | 2020-02-26 15:06:47 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-02-26 | Feb | 26 | 2020 | Wednesday |   0 |\n",
       "| 794264334D168D05 | 2020-03-18 11:43:09 | 2020-03-18 11:42:58 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday | -11 |\n",
       "| 395F2D12B8A335B8 | 2020-03-18 10:49:33 | 2020-03-18 10:49:33 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday |   0 |\n",
       "| 3CC0D87545CE223B | 2020-03-19 09:43:05 | 2020-03-19 09:42:51 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-19 | Mar | 19 | 2020 | Thursday  | -14 |\n",
       "| 5D5E9B7782A62F66 | 2020-03-19 09:44:04 | 2020-03-19 09:44:04 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-19 | Mar | 19 | 2020 | Thursday  |   0 |\n",
       "| 32CAF6E2E7AB67CE | 2020-03-12 10:00:46 | 2020-03-12 10:00:36 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-12 | Mar | 12 | 2020 | Thursday  | -10 |\n",
       "| 88D98921A2382D2F | 2020-03-04 11:44:56 | 2020-03-04 11:44:56 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-04 | Mar | 04 | 2020 | Wednesday |   0 |\n",
       "| 13BCB74BAFDADB21 | 2020-03-27 14:59:51 | 2020-03-27 14:58:18 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-27 | Mar | 27 | 2020 | Friday    | -93 |\n",
       "| 4EF350E51E6037AF | 2020-03-19 09:37:17 | 2020-03-19 09:37:04 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-19 | Mar | 19 | 2020 | Thursday  | -13 |\n",
       "| D96C52A466344F56 | 2020-03-12 09:27:31 | 2020-03-12 09:27:20 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-12 | Mar | 12 | 2020 | Thursday  | -11 |\n",
       "| A7491869619B539E | 2020-03-17 12:22:18 | 2020-03-17 12:22:07 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-17 | Mar | 17 | 2020 | Tuesday   | -11 |\n",
       "| 50F979A1289A1621 | 2020-03-02 09:27:10 | 2020-03-02 09:27:10 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-02 | Mar | 02 | 2020 | Monday    |   0 |\n",
       "| DC6D24FB727542F1 | 2020-03-20 09:00:53 | 2020-03-20 09:00:40 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-20 | Mar | 20 | 2020 | Friday    | -13 |\n",
       "| 7DC201C78AA1DACA | 2020-03-02 12:29:37 | 2020-03-02 12:29:37 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-02 | Mar | 02 | 2020 | Monday    |   0 |\n",
       "| C95725BA7EBD1498 | 2020-03-18 12:24:02 | 2020-03-18 12:23:51 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday | -11 |\n",
       "| 5C83D9F28FBE25B3 | 2020-03-16 14:03:10 | 2020-03-16 14:03:10 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-16 | Mar | 16 | 2020 | Monday    |   0 |\n",
       "| 86F9E9C2AEAAF5A1 | 2020-03-12 09:39:52 | 2020-03-12 09:39:52 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-12 | Mar | 12 | 2020 | Thursday  |   0 |\n",
       "| 22B7786E02DB39AD | 2020-03-20 09:13:26 | 2020-03-20 09:13:12 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-20 | Mar | 20 | 2020 | Friday    | -14 |\n",
       "| F46A4E6332A8C4CB | 2020-03-02 09:27:10 | 2020-03-02 09:27:10 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-02 | Mar | 02 | 2020 | Monday    |   0 |\n",
       "| 8151A1ECCD4115C9 | 2020-03-20 10:01:22 | 2020-03-20 10:01:10 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-20 | Mar | 20 | 2020 | Friday    | -12 |\n",
       "| 0CFB4DBF0FDAD733 | 2020-03-18 10:55:07 | 2020-03-18 10:54:55 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday | -12 |\n",
       "| ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ |\n",
       "| 5FC950EA4F49BD1B | 2020-03-02 10:02:13 | 2020-03-02 10:02:13 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-02 | Mar | 02 | 2020 | Monday    |   0 |\n",
       "| E61408AB2A41D15D | 2020-03-16 11:41:23 | 2020-03-16 11:41:11 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-16 | Mar | 16 | 2020 | Monday    | -12 |\n",
       "| 2218A4D928820E6E | 2020-03-18 09:37:11 | 2020-03-18 09:36:59 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday | -12 |\n",
       "| B0565BEDAF8D721F | 2020-03-18 11:30:34 | 2020-03-18 11:30:12 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday | -22 |\n",
       "| 6E739A980BFEA8F4 | 2020-03-09 13:24:41 | 2020-03-09 13:24:41 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-09 | Mar | 09 | 2020 | Monday    |   0 |\n",
       "| 22CDAB1855EFB928 | 2020-03-16 11:43:49 | 2020-03-16 11:43:38 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-16 | Mar | 16 | 2020 | Monday    | -11 |\n",
       "| 4B1478D45C94AB00 | 2020-03-18 11:34:05 | 2020-03-18 11:33:53 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday | -12 |\n",
       "| 992E918554162BAF | 2020-03-02 14:01:31 | 2020-03-02 14:01:31 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-02 | Mar | 02 | 2020 | Monday    |   0 |\n",
       "| 5285E8EBDF67F7EB | 2020-03-12 09:16:04 | 2020-03-12 09:15:54 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-12 | Mar | 12 | 2020 | Thursday  | -10 |\n",
       "| 2E2C3F0A1CBC11BF | 2020-03-20 09:08:01 | 2020-03-20 09:08:01 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-20 | Mar | 20 | 2020 | Friday    |   0 |\n",
       "| 6BB28B54D146A2A0 | 2020-03-19 10:37:51 | 2020-03-19 10:37:38 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-19 | Mar | 19 | 2020 | Thursday  | -13 |\n",
       "| 54D18287D2AA2F1C | 2020-03-10 10:37:08 | 2020-03-10 10:37:08 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-10 | Mar | 10 | 2020 | Tuesday   |   0 |\n",
       "| 7248AE8F5CD8BF91 | 2020-03-16 09:42:14 | 2020-03-16 09:42:03 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-16 | Mar | 16 | 2020 | Monday    | -11 |\n",
       "| AE7E1838C92E15CB | 2020-03-18 14:31:52 | 2020-03-18 14:31:40 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday | -12 |\n",
       "| 157EAA4C4A3C8D36 | 2020-03-16 11:23:36 | 2020-03-16 11:23:24 | docked_bike | 675 | HQ QR |  NA | NA    | casual | 2020-03-16 | Mar | 16 | 2020 | Monday    | -12 |\n",
       "| 3F70F88E187745B7 | 2020-03-18 10:18:52 | 2020-03-18 10:18:52 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday |   0 |\n",
       "| DB6502CD28E046D7 | 2020-03-05 09:07:29 | 2020-03-05 09:07:29 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-05 | Mar | 05 | 2020 | Thursday  |   0 |\n",
       "| 3F591668748DC77B | 2020-03-12 09:58:26 | 2020-03-12 09:58:14 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-12 | Mar | 12 | 2020 | Thursday  | -12 |\n",
       "| CA49582758849EE5 | 2020-03-18 09:16:46 | 2020-03-18 09:16:35 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday | -11 |\n",
       "| A97C7A198F879C4E | 2020-03-18 09:17:25 | 2020-03-18 09:17:25 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday |   0 |\n",
       "| C2F71E40D52A0660 | 2020-03-18 15:12:18 | 2020-03-18 15:12:04 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-18 | Mar | 18 | 2020 | Wednesday | -14 |\n",
       "| 14AF5815838B9F2C | 2020-03-13 08:38:14 | 2020-03-13 08:38:03 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-13 | Mar | 13 | 2020 | Friday    | -11 |\n",
       "| 8C8F5D8DE7FBF8D0 | 2020-03-02 09:46:48 | 2020-03-02 09:46:48 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-02 | Mar | 02 | 2020 | Monday    |   0 |\n",
       "| C5BDA1DB624F3658 | 2020-03-19 10:04:31 | 2020-03-19 10:04:31 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-19 | Mar | 19 | 2020 | Thursday  |   0 |\n",
       "| D94EF149247F3880 | 2020-03-19 10:24:16 | 2020-03-19 10:24:05 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-19 | Mar | 19 | 2020 | Thursday  | -11 |\n",
       "| 09C4B33945876A83 | 2020-03-10 09:54:23 | 2020-03-10 09:54:23 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-10 | Mar | 10 | 2020 | Tuesday   |   0 |\n",
       "| 323CAC41316F59B2 | 2020-03-13 08:51:45 | 2020-03-13 08:51:34 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-13 | Mar | 13 | 2020 | Friday    | -11 |\n",
       "| 476717BBABCAE518 | 2020-03-19 09:31:56 | 2020-03-19 09:31:45 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-19 | Mar | 19 | 2020 | Thursday  | -11 |\n",
       "| F809003AA48EC0C1 | 2020-03-09 12:12:59 | 2020-03-09 12:12:59 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-09 | Mar | 09 | 2020 | Monday    |   0 |\n",
       "| 57FF6A81E9517A6E | 2020-03-16 13:42:39 | 2020-03-16 13:42:39 | docked_bike | 675 | HQ QR | 675 | HQ QR | casual | 2020-03-16 | Mar | 16 | 2020 | Monday    |   0 |\n",
       "\n"
      ],
      "text/plain": [
       "    ride_id          started_at          ended_at            rideable_type\n",
       "1   23EF1DCC9FCA40BA 2020-02-28 11:34:40 2020-02-28 11:34:40 docked_bike  \n",
       "2   9461DFF13D8BA8AD 2020-02-28 10:09:43 2020-02-28 10:09:42 docked_bike  \n",
       "3   86163D9676BBBE62 2020-02-26 14:41:16 2020-02-26 14:41:16 docked_bike  \n",
       "4   836931C569802344 2020-02-27 09:56:47 2020-02-27 09:56:47 docked_bike  \n",
       "5   07CD3CBC94106B37 2020-02-28 10:02:30 2020-02-28 10:02:30 docked_bike  \n",
       "6   83D849E5C5716FA3 2020-02-28 10:39:01 2020-02-28 10:39:01 docked_bike  \n",
       "7   4BF5C10795152574 2020-02-26 15:11:49 2020-02-26 15:11:49 docked_bike  \n",
       "8   6EB2E392C75D5246 2020-02-26 12:49:59 2020-02-26 12:49:59 docked_bike  \n",
       "9   8B167ABFC026622D 2020-02-26 12:50:52 2020-02-26 12:50:52 docked_bike  \n",
       "10  4CCD45F6BA577FF3 2020-02-26 15:06:47 2020-02-26 15:06:47 docked_bike  \n",
       "11  794264334D168D05 2020-03-18 11:43:09 2020-03-18 11:42:58 docked_bike  \n",
       "12  395F2D12B8A335B8 2020-03-18 10:49:33 2020-03-18 10:49:33 docked_bike  \n",
       "13  3CC0D87545CE223B 2020-03-19 09:43:05 2020-03-19 09:42:51 docked_bike  \n",
       "14  5D5E9B7782A62F66 2020-03-19 09:44:04 2020-03-19 09:44:04 docked_bike  \n",
       "15  32CAF6E2E7AB67CE 2020-03-12 10:00:46 2020-03-12 10:00:36 docked_bike  \n",
       "16  88D98921A2382D2F 2020-03-04 11:44:56 2020-03-04 11:44:56 docked_bike  \n",
       "17  13BCB74BAFDADB21 2020-03-27 14:59:51 2020-03-27 14:58:18 docked_bike  \n",
       "18  4EF350E51E6037AF 2020-03-19 09:37:17 2020-03-19 09:37:04 docked_bike  \n",
       "19  D96C52A466344F56 2020-03-12 09:27:31 2020-03-12 09:27:20 docked_bike  \n",
       "20  A7491869619B539E 2020-03-17 12:22:18 2020-03-17 12:22:07 docked_bike  \n",
       "21  50F979A1289A1621 2020-03-02 09:27:10 2020-03-02 09:27:10 docked_bike  \n",
       "22  DC6D24FB727542F1 2020-03-20 09:00:53 2020-03-20 09:00:40 docked_bike  \n",
       "23  7DC201C78AA1DACA 2020-03-02 12:29:37 2020-03-02 12:29:37 docked_bike  \n",
       "24  C95725BA7EBD1498 2020-03-18 12:24:02 2020-03-18 12:23:51 docked_bike  \n",
       "25  5C83D9F28FBE25B3 2020-03-16 14:03:10 2020-03-16 14:03:10 docked_bike  \n",
       "26  86F9E9C2AEAAF5A1 2020-03-12 09:39:52 2020-03-12 09:39:52 docked_bike  \n",
       "27  22B7786E02DB39AD 2020-03-20 09:13:26 2020-03-20 09:13:12 docked_bike  \n",
       "28  F46A4E6332A8C4CB 2020-03-02 09:27:10 2020-03-02 09:27:10 docked_bike  \n",
       "29  8151A1ECCD4115C9 2020-03-20 10:01:22 2020-03-20 10:01:10 docked_bike  \n",
       "30  0CFB4DBF0FDAD733 2020-03-18 10:55:07 2020-03-18 10:54:55 docked_bike  \n",
       "⋮   ⋮                ⋮                   ⋮                   ⋮            \n",
       "181 5FC950EA4F49BD1B 2020-03-02 10:02:13 2020-03-02 10:02:13 docked_bike  \n",
       "182 E61408AB2A41D15D 2020-03-16 11:41:23 2020-03-16 11:41:11 docked_bike  \n",
       "183 2218A4D928820E6E 2020-03-18 09:37:11 2020-03-18 09:36:59 docked_bike  \n",
       "184 B0565BEDAF8D721F 2020-03-18 11:30:34 2020-03-18 11:30:12 docked_bike  \n",
       "185 6E739A980BFEA8F4 2020-03-09 13:24:41 2020-03-09 13:24:41 docked_bike  \n",
       "186 22CDAB1855EFB928 2020-03-16 11:43:49 2020-03-16 11:43:38 docked_bike  \n",
       "187 4B1478D45C94AB00 2020-03-18 11:34:05 2020-03-18 11:33:53 docked_bike  \n",
       "188 992E918554162BAF 2020-03-02 14:01:31 2020-03-02 14:01:31 docked_bike  \n",
       "189 5285E8EBDF67F7EB 2020-03-12 09:16:04 2020-03-12 09:15:54 docked_bike  \n",
       "190 2E2C3F0A1CBC11BF 2020-03-20 09:08:01 2020-03-20 09:08:01 docked_bike  \n",
       "191 6BB28B54D146A2A0 2020-03-19 10:37:51 2020-03-19 10:37:38 docked_bike  \n",
       "192 54D18287D2AA2F1C 2020-03-10 10:37:08 2020-03-10 10:37:08 docked_bike  \n",
       "193 7248AE8F5CD8BF91 2020-03-16 09:42:14 2020-03-16 09:42:03 docked_bike  \n",
       "194 AE7E1838C92E15CB 2020-03-18 14:31:52 2020-03-18 14:31:40 docked_bike  \n",
       "195 157EAA4C4A3C8D36 2020-03-16 11:23:36 2020-03-16 11:23:24 docked_bike  \n",
       "196 3F70F88E187745B7 2020-03-18 10:18:52 2020-03-18 10:18:52 docked_bike  \n",
       "197 DB6502CD28E046D7 2020-03-05 09:07:29 2020-03-05 09:07:29 docked_bike  \n",
       "198 3F591668748DC77B 2020-03-12 09:58:26 2020-03-12 09:58:14 docked_bike  \n",
       "199 CA49582758849EE5 2020-03-18 09:16:46 2020-03-18 09:16:35 docked_bike  \n",
       "200 A97C7A198F879C4E 2020-03-18 09:17:25 2020-03-18 09:17:25 docked_bike  \n",
       "201 C2F71E40D52A0660 2020-03-18 15:12:18 2020-03-18 15:12:04 docked_bike  \n",
       "202 14AF5815838B9F2C 2020-03-13 08:38:14 2020-03-13 08:38:03 docked_bike  \n",
       "203 8C8F5D8DE7FBF8D0 2020-03-02 09:46:48 2020-03-02 09:46:48 docked_bike  \n",
       "204 C5BDA1DB624F3658 2020-03-19 10:04:31 2020-03-19 10:04:31 docked_bike  \n",
       "205 D94EF149247F3880 2020-03-19 10:24:16 2020-03-19 10:24:05 docked_bike  \n",
       "206 09C4B33945876A83 2020-03-10 09:54:23 2020-03-10 09:54:23 docked_bike  \n",
       "207 323CAC41316F59B2 2020-03-13 08:51:45 2020-03-13 08:51:34 docked_bike  \n",
       "208 476717BBABCAE518 2020-03-19 09:31:56 2020-03-19 09:31:45 docked_bike  \n",
       "209 F809003AA48EC0C1 2020-03-09 12:12:59 2020-03-09 12:12:59 docked_bike  \n",
       "210 57FF6A81E9517A6E 2020-03-16 13:42:39 2020-03-16 13:42:39 docked_bike  \n",
       "    start_station_id start_station_name end_station_id end_station_name\n",
       "1   675              HQ QR              675            HQ QR           \n",
       "2   675              HQ QR              675            HQ QR           \n",
       "3   675              HQ QR              675            HQ QR           \n",
       "4   675              HQ QR              675            HQ QR           \n",
       "5   675              HQ QR              675            HQ QR           \n",
       "6   675              HQ QR              675            HQ QR           \n",
       "7   675              HQ QR              675            HQ QR           \n",
       "8   675              HQ QR              675            HQ QR           \n",
       "9   675              HQ QR              675            HQ QR           \n",
       "10  675              HQ QR              675            HQ QR           \n",
       "11  675              HQ QR              675            HQ QR           \n",
       "12  675              HQ QR              675            HQ QR           \n",
       "13  675              HQ QR              675            HQ QR           \n",
       "14  675              HQ QR              675            HQ QR           \n",
       "15  675              HQ QR              675            HQ QR           \n",
       "16  675              HQ QR              675            HQ QR           \n",
       "17  675              HQ QR              675            HQ QR           \n",
       "18  675              HQ QR              675            HQ QR           \n",
       "19  675              HQ QR              675            HQ QR           \n",
       "20  675              HQ QR              675            HQ QR           \n",
       "21  675              HQ QR              675            HQ QR           \n",
       "22  675              HQ QR              675            HQ QR           \n",
       "23  675              HQ QR              675            HQ QR           \n",
       "24  675              HQ QR              675            HQ QR           \n",
       "25  675              HQ QR              675            HQ QR           \n",
       "26  675              HQ QR              675            HQ QR           \n",
       "27  675              HQ QR              675            HQ QR           \n",
       "28  675              HQ QR              675            HQ QR           \n",
       "29  675              HQ QR              675            HQ QR           \n",
       "30  675              HQ QR              675            HQ QR           \n",
       "⋮   ⋮                ⋮                  ⋮              ⋮               \n",
       "181 675              HQ QR              675            HQ QR           \n",
       "182 675              HQ QR              675            HQ QR           \n",
       "183 675              HQ QR              675            HQ QR           \n",
       "184 675              HQ QR              675            HQ QR           \n",
       "185 675              HQ QR              675            HQ QR           \n",
       "186 675              HQ QR              675            HQ QR           \n",
       "187 675              HQ QR              675            HQ QR           \n",
       "188 675              HQ QR              675            HQ QR           \n",
       "189 675              HQ QR              675            HQ QR           \n",
       "190 675              HQ QR              675            HQ QR           \n",
       "191 675              HQ QR              675            HQ QR           \n",
       "192 675              HQ QR              675            HQ QR           \n",
       "193 675              HQ QR              675            HQ QR           \n",
       "194 675              HQ QR              675            HQ QR           \n",
       "195 675              HQ QR               NA            NA              \n",
       "196 675              HQ QR              675            HQ QR           \n",
       "197 675              HQ QR              675            HQ QR           \n",
       "198 675              HQ QR              675            HQ QR           \n",
       "199 675              HQ QR              675            HQ QR           \n",
       "200 675              HQ QR              675            HQ QR           \n",
       "201 675              HQ QR              675            HQ QR           \n",
       "202 675              HQ QR              675            HQ QR           \n",
       "203 675              HQ QR              675            HQ QR           \n",
       "204 675              HQ QR              675            HQ QR           \n",
       "205 675              HQ QR              675            HQ QR           \n",
       "206 675              HQ QR              675            HQ QR           \n",
       "207 675              HQ QR              675            HQ QR           \n",
       "208 675              HQ QR              675            HQ QR           \n",
       "209 675              HQ QR              675            HQ QR           \n",
       "210 675              HQ QR              675            HQ QR           \n",
       "    member_casual date       month day year day_of_week ride_length\n",
       "1   casual        2020-02-28 Feb   28  2020 Friday        0        \n",
       "2   casual        2020-02-28 Feb   28  2020 Friday       -1        \n",
       "3   casual        2020-02-26 Feb   26  2020 Wednesday     0        \n",
       "4   casual        2020-02-27 Feb   27  2020 Thursday      0        \n",
       "5   casual        2020-02-28 Feb   28  2020 Friday        0        \n",
       "6   casual        2020-02-28 Feb   28  2020 Friday        0        \n",
       "7   casual        2020-02-26 Feb   26  2020 Wednesday     0        \n",
       "8   casual        2020-02-26 Feb   26  2020 Wednesday     0        \n",
       "9   casual        2020-02-26 Feb   26  2020 Wednesday     0        \n",
       "10  casual        2020-02-26 Feb   26  2020 Wednesday     0        \n",
       "11  casual        2020-03-18 Mar   18  2020 Wednesday   -11        \n",
       "12  casual        2020-03-18 Mar   18  2020 Wednesday     0        \n",
       "13  casual        2020-03-19 Mar   19  2020 Thursday    -14        \n",
       "14  casual        2020-03-19 Mar   19  2020 Thursday      0        \n",
       "15  casual        2020-03-12 Mar   12  2020 Thursday    -10        \n",
       "16  casual        2020-03-04 Mar   04  2020 Wednesday     0        \n",
       "17  casual        2020-03-27 Mar   27  2020 Friday      -93        \n",
       "18  casual        2020-03-19 Mar   19  2020 Thursday    -13        \n",
       "19  casual        2020-03-12 Mar   12  2020 Thursday    -11        \n",
       "20  casual        2020-03-17 Mar   17  2020 Tuesday     -11        \n",
       "21  casual        2020-03-02 Mar   02  2020 Monday        0        \n",
       "22  casual        2020-03-20 Mar   20  2020 Friday      -13        \n",
       "23  casual        2020-03-02 Mar   02  2020 Monday        0        \n",
       "24  casual        2020-03-18 Mar   18  2020 Wednesday   -11        \n",
       "25  casual        2020-03-16 Mar   16  2020 Monday        0        \n",
       "26  casual        2020-03-12 Mar   12  2020 Thursday      0        \n",
       "27  casual        2020-03-20 Mar   20  2020 Friday      -14        \n",
       "28  casual        2020-03-02 Mar   02  2020 Monday        0        \n",
       "29  casual        2020-03-20 Mar   20  2020 Friday      -12        \n",
       "30  casual        2020-03-18 Mar   18  2020 Wednesday   -12        \n",
       "⋮   ⋮             ⋮          ⋮     ⋮   ⋮    ⋮           ⋮          \n",
       "181 casual        2020-03-02 Mar   02  2020 Monday        0        \n",
       "182 casual        2020-03-16 Mar   16  2020 Monday      -12        \n",
       "183 casual        2020-03-18 Mar   18  2020 Wednesday   -12        \n",
       "184 casual        2020-03-18 Mar   18  2020 Wednesday   -22        \n",
       "185 casual        2020-03-09 Mar   09  2020 Monday        0        \n",
       "186 casual        2020-03-16 Mar   16  2020 Monday      -11        \n",
       "187 casual        2020-03-18 Mar   18  2020 Wednesday   -12        \n",
       "188 casual        2020-03-02 Mar   02  2020 Monday        0        \n",
       "189 casual        2020-03-12 Mar   12  2020 Thursday    -10        \n",
       "190 casual        2020-03-20 Mar   20  2020 Friday        0        \n",
       "191 casual        2020-03-19 Mar   19  2020 Thursday    -13        \n",
       "192 casual        2020-03-10 Mar   10  2020 Tuesday       0        \n",
       "193 casual        2020-03-16 Mar   16  2020 Monday      -11        \n",
       "194 casual        2020-03-18 Mar   18  2020 Wednesday   -12        \n",
       "195 casual        2020-03-16 Mar   16  2020 Monday      -12        \n",
       "196 casual        2020-03-18 Mar   18  2020 Wednesday     0        \n",
       "197 casual        2020-03-05 Mar   05  2020 Thursday      0        \n",
       "198 casual        2020-03-12 Mar   12  2020 Thursday    -12        \n",
       "199 casual        2020-03-18 Mar   18  2020 Wednesday   -11        \n",
       "200 casual        2020-03-18 Mar   18  2020 Wednesday     0        \n",
       "201 casual        2020-03-18 Mar   18  2020 Wednesday   -14        \n",
       "202 casual        2020-03-13 Mar   13  2020 Friday      -11        \n",
       "203 casual        2020-03-02 Mar   02  2020 Monday        0        \n",
       "204 casual        2020-03-19 Mar   19  2020 Thursday      0        \n",
       "205 casual        2020-03-19 Mar   19  2020 Thursday    -11        \n",
       "206 casual        2020-03-10 Mar   10  2020 Tuesday       0        \n",
       "207 casual        2020-03-13 Mar   13  2020 Friday      -11        \n",
       "208 casual        2020-03-19 Mar   19  2020 Thursday    -11        \n",
       "209 casual        2020-03-09 Mar   09  2020 Monday        0        \n",
       "210 casual        2020-03-16 Mar   16  2020 Monday        0        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "all_trips %>% \n",
    "  dplyr::filter(ride_length < 1)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "4a8adaa3",
   "metadata": {
    "papermill": {
     "duration": 0.019681,
     "end_time": "2024-06-25T09:56:48.972452",
     "exception": false,
     "start_time": "2024-06-25T09:56:48.952771",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* We will create a new version of the dataframe (v2) since data is being removed"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 30,
   "id": "d6ae5637",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:49.015732Z",
     "iopub.status.busy": "2024-06-25T09:56:49.014063Z",
     "iopub.status.idle": "2024-06-25T09:56:49.129328Z",
     "shell.execute_reply": "2024-06-25T09:56:49.127473Z"
    },
    "papermill": {
     "duration": 0.139673,
     "end_time": "2024-06-25T09:56:49.131911",
     "exception": false,
     "start_time": "2024-06-25T09:56:48.992238",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips_v2 <- all_trips[!(all_trips$start_station_name == \"HQ QR\" | all_trips$ride_length < 0),]"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "fbc51032",
   "metadata": {
    "papermill": {
     "duration": 0.020148,
     "end_time": "2024-06-25T09:56:49.172522",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.152374",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "The \"|\" stands for \"OR\""
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8fdc682b",
   "metadata": {
    "papermill": {
     "duration": 0.022989,
     "end_time": "2024-06-25T09:56:49.215502",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.192513",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Conduct Descriptive Analysis\n",
    "* Descriptive analysis on ride_length (all figures in seconds)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 31,
   "id": "3d101a83",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:49.272797Z",
     "iopub.status.busy": "2024-06-25T09:56:49.270367Z",
     "iopub.status.idle": "2024-06-25T09:56:49.299246Z",
     "shell.execute_reply": "2024-06-25T09:56:49.296401Z"
    },
    "papermill": {
     "duration": 0.062338,
     "end_time": "2024-06-25T09:56:49.302571",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.240233",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "1189.45868820803"
      ],
      "text/latex": [
       "1189.45868820803"
      ],
      "text/markdown": [
       "1189.45868820803"
      ],
      "text/plain": [
       "[1] 1189.459"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "mean(all_trips_v2$ride_length)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "004e2fc5",
   "metadata": {
    "papermill": {
     "duration": 0.021085,
     "end_time": "2024-06-25T09:56:49.345120",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.324035",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "straight average (total ride length / rides)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 32,
   "id": "cbdb52e3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:49.394917Z",
     "iopub.status.busy": "2024-06-25T09:56:49.393194Z",
     "iopub.status.idle": "2024-06-25T09:56:49.440369Z",
     "shell.execute_reply": "2024-06-25T09:56:49.438089Z"
    },
    "papermill": {
     "duration": 0.074761,
     "end_time": "2024-06-25T09:56:49.443382",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.368621",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "539"
      ],
      "text/latex": [
       "539"
      ],
      "text/markdown": [
       "539"
      ],
      "text/plain": [
       "[1] 539"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "median(all_trips_v2$ride_length)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "54886dba",
   "metadata": {
    "papermill": {
     "duration": 0.021967,
     "end_time": "2024-06-25T09:56:49.485990",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.464023",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "midpoint number in the ascending array of ride lengths"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 33,
   "id": "e504663b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:49.536588Z",
     "iopub.status.busy": "2024-06-25T09:56:49.534945Z",
     "iopub.status.idle": "2024-06-25T09:56:49.556666Z",
     "shell.execute_reply": "2024-06-25T09:56:49.554235Z"
    },
    "papermill": {
     "duration": 0.047738,
     "end_time": "2024-06-25T09:56:49.559752",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.512014",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "10632022"
      ],
      "text/latex": [
       "10632022"
      ],
      "text/markdown": [
       "10632022"
      ],
      "text/plain": [
       "[1] 10632022"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "max(all_trips_v2$ride_length)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "05537e77",
   "metadata": {
    "papermill": {
     "duration": 0.02077,
     "end_time": "2024-06-25T09:56:49.601301",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.580531",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "longest ride"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 34,
   "id": "f36ff585",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:49.646469Z",
     "iopub.status.busy": "2024-06-25T09:56:49.644911Z",
     "iopub.status.idle": "2024-06-25T09:56:49.670030Z",
     "shell.execute_reply": "2024-06-25T09:56:49.667670Z"
    },
    "papermill": {
     "duration": 0.051413,
     "end_time": "2024-06-25T09:56:49.673247",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.621834",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "1"
      ],
      "text/latex": [
       "1"
      ],
      "text/markdown": [
       "1"
      ],
      "text/plain": [
       "[1] 1"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "min(all_trips_v2$ride_length)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "19cda54e",
   "metadata": {
    "papermill": {
     "duration": 0.02104,
     "end_time": "2024-06-25T09:56:49.718129",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.697089",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "shortest ride"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d2434321",
   "metadata": {
    "papermill": {
     "duration": 0.020724,
     "end_time": "2024-06-25T09:56:49.759762",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.739038",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Condense the four lines above to one line using summary() on the specific attribute"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 35,
   "id": "055ff487",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:49.806655Z",
     "iopub.status.busy": "2024-06-25T09:56:49.804989Z",
     "iopub.status.idle": "2024-06-25T09:56:49.926689Z",
     "shell.execute_reply": "2024-06-25T09:56:49.924540Z"
    },
    "papermill": {
     "duration": 0.148932,
     "end_time": "2024-06-25T09:56:49.929650",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.780718",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. \n",
       "       1      331      539     1189      912 10632022 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(all_trips_v2$ride_length)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "65ce2d06",
   "metadata": {
    "papermill": {
     "duration": 0.020734,
     "end_time": "2024-06-25T09:56:49.970695",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.949961",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Compare members and casual users"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 36,
   "id": "c96f47a2",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:50.015111Z",
     "iopub.status.busy": "2024-06-25T09:56:50.013504Z",
     "iopub.status.idle": "2024-06-25T09:56:50.798750Z",
     "shell.execute_reply": "2024-06-25T09:56:50.796959Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.810365,
     "end_time": "2024-06-25T09:56:50.801644",
     "exception": false,
     "start_time": "2024-06-25T09:56:49.991279",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>5372.7839</td></tr>\n",
       "\t<tr><td>member</td><td> 795.2523</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 5372.7839\\\\\n",
       "\t member &  795.2523\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 5372.7839 |\n",
       "| member |  795.2523 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     5372.7839               \n",
       "2 member                      795.2523               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 37,
   "id": "ba3f5c82",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:50.849251Z",
     "iopub.status.busy": "2024-06-25T09:56:50.847605Z",
     "iopub.status.idle": "2024-06-25T09:56:51.265577Z",
     "shell.execute_reply": "2024-06-25T09:56:51.263796Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.444529,
     "end_time": "2024-06-25T09:56:51.268082",
     "exception": false,
     "start_time": "2024-06-25T09:56:50.823553",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>5372.7839</td></tr>\n",
       "\t<tr><td>member</td><td> 795.2523</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 5372.7839\\\\\n",
       "\t member &  795.2523\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 5372.7839 |\n",
       "| member |  795.2523 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     5372.7839               \n",
       "2 member                      795.2523               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 38,
   "id": "7e38aca4",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:51.314002Z",
     "iopub.status.busy": "2024-06-25T09:56:51.312395Z",
     "iopub.status.idle": "2024-06-25T09:56:52.092621Z",
     "shell.execute_reply": "2024-06-25T09:56:52.090876Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.805594,
     "end_time": "2024-06-25T09:56:52.095100",
     "exception": false,
     "start_time": "2024-06-25T09:56:51.289506",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>1393</td></tr>\n",
       "\t<tr><td>member</td><td> 508</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 1393\\\\\n",
       "\t member &  508\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 1393 |\n",
       "| member |  508 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     1393                    \n",
       "2 member                      508                    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 39,
   "id": "4a3bbf9c",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:52.143105Z",
     "iopub.status.busy": "2024-06-25T09:56:52.141498Z",
     "iopub.status.idle": "2024-06-25T09:56:52.529371Z",
     "shell.execute_reply": "2024-06-25T09:56:52.527575Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.415607,
     "end_time": "2024-06-25T09:56:52.531939",
     "exception": false,
     "start_time": "2024-06-25T09:56:52.116332",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>10632022</td></tr>\n",
       "\t<tr><td>member</td><td> 6096428</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 10632022\\\\\n",
       "\t member &  6096428\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 10632022 |\n",
       "| member |  6096428 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     10632022                \n",
       "2 member                      6096428                "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 40,
   "id": "da5dd311",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:52.578999Z",
     "iopub.status.busy": "2024-06-25T09:56:52.577373Z",
     "iopub.status.idle": "2024-06-25T09:56:52.961367Z",
     "shell.execute_reply": "2024-06-25T09:56:52.959489Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.410335,
     "end_time": "2024-06-25T09:56:52.963745",
     "exception": false,
     "start_time": "2024-06-25T09:56:52.553410",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>2</td></tr>\n",
       "\t<tr><td>member</td><td>1</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 2\\\\\n",
       "\t member & 1\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 2 |\n",
       "| member | 1 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     2                       \n",
       "2 member                     1                       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "e75fd2dd",
   "metadata": {
    "papermill": {
     "duration": 0.021498,
     "end_time": "2024-06-25T09:56:53.007064",
     "exception": false,
     "start_time": "2024-06-25T09:56:52.985566",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* See the average ride time by each day for members vs casual users"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 41,
   "id": "3d09e686",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:53.053467Z",
     "iopub.status.busy": "2024-06-25T09:56:53.051896Z",
     "iopub.status.idle": "2024-06-25T09:56:53.839685Z",
     "shell.execute_reply": "2024-06-25T09:56:53.837925Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.813739,
     "end_time": "2024-06-25T09:56:53.842134",
     "exception": false,
     "start_time": "2024-06-25T09:56:53.028395",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 14 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$day_of_week</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>Friday   </td><td>6090.7373</td></tr>\n",
       "\t<tr><td>member</td><td>Friday   </td><td> 796.7338</td></tr>\n",
       "\t<tr><td>casual</td><td>Monday   </td><td>4752.0504</td></tr>\n",
       "\t<tr><td>member</td><td>Monday   </td><td> 822.3112</td></tr>\n",
       "\t<tr><td>casual</td><td>Saturday </td><td>4950.7708</td></tr>\n",
       "\t<tr><td>member</td><td>Saturday </td><td> 974.0730</td></tr>\n",
       "\t<tr><td>casual</td><td>Sunday   </td><td>5061.3044</td></tr>\n",
       "\t<tr><td>member</td><td>Sunday   </td><td> 972.9383</td></tr>\n",
       "\t<tr><td>casual</td><td>Thursday </td><td>8451.6669</td></tr>\n",
       "\t<tr><td>member</td><td>Thursday </td><td> 707.2093</td></tr>\n",
       "\t<tr><td>casual</td><td>Tuesday  </td><td>4561.8039</td></tr>\n",
       "\t<tr><td>member</td><td>Tuesday  </td><td> 769.4416</td></tr>\n",
       "\t<tr><td>casual</td><td>Wednesday</td><td>4480.3724</td></tr>\n",
       "\t<tr><td>member</td><td>Wednesday</td><td> 711.9838</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 14 × 3\n",
       "\\begin{tabular}{lll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$day\\_of\\_week & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & Friday    & 6090.7373\\\\\n",
       "\t member & Friday    &  796.7338\\\\\n",
       "\t casual & Monday    & 4752.0504\\\\\n",
       "\t member & Monday    &  822.3112\\\\\n",
       "\t casual & Saturday  & 4950.7708\\\\\n",
       "\t member & Saturday  &  974.0730\\\\\n",
       "\t casual & Sunday    & 5061.3044\\\\\n",
       "\t member & Sunday    &  972.9383\\\\\n",
       "\t casual & Thursday  & 8451.6669\\\\\n",
       "\t member & Thursday  &  707.2093\\\\\n",
       "\t casual & Tuesday   & 4561.8039\\\\\n",
       "\t member & Tuesday   &  769.4416\\\\\n",
       "\t casual & Wednesday & 4480.3724\\\\\n",
       "\t member & Wednesday &  711.9838\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 14 × 3\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$day_of_week &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| casual | Friday    | 6090.7373 |\n",
       "| member | Friday    |  796.7338 |\n",
       "| casual | Monday    | 4752.0504 |\n",
       "| member | Monday    |  822.3112 |\n",
       "| casual | Saturday  | 4950.7708 |\n",
       "| member | Saturday  |  974.0730 |\n",
       "| casual | Sunday    | 5061.3044 |\n",
       "| member | Sunday    |  972.9383 |\n",
       "| casual | Thursday  | 8451.6669 |\n",
       "| member | Thursday  |  707.2093 |\n",
       "| casual | Tuesday   | 4561.8039 |\n",
       "| member | Tuesday   |  769.4416 |\n",
       "| casual | Wednesday | 4480.3724 |\n",
       "| member | Wednesday |  711.9838 |\n",
       "\n"
      ],
      "text/plain": [
       "   all_trips_v2$member_casual all_trips_v2$day_of_week all_trips_v2$ride_length\n",
       "1  casual                     Friday                   6090.7373               \n",
       "2  member                     Friday                    796.7338               \n",
       "3  casual                     Monday                   4752.0504               \n",
       "4  member                     Monday                    822.3112               \n",
       "5  casual                     Saturday                 4950.7708               \n",
       "6  member                     Saturday                  974.0730               \n",
       "7  casual                     Sunday                   5061.3044               \n",
       "8  member                     Sunday                    972.9383               \n",
       "9  casual                     Thursday                 8451.6669               \n",
       "10 member                     Thursday                  707.2093               \n",
       "11 casual                     Tuesday                  4561.8039               \n",
       "12 member                     Tuesday                   769.4416               \n",
       "13 casual                     Wednesday                4480.3724               \n",
       "14 member                     Wednesday                 711.9838               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "49d03945",
   "metadata": {
    "papermill": {
     "duration": 0.02179,
     "end_time": "2024-06-25T09:56:53.886387",
     "exception": false,
     "start_time": "2024-06-25T09:56:53.864597",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Notice that the days of the week are out of order. Let's fix that."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 42,
   "id": "e974ca12",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:53.933460Z",
     "iopub.status.busy": "2024-06-25T09:56:53.931885Z",
     "iopub.status.idle": "2024-06-25T09:56:53.958723Z",
     "shell.execute_reply": "2024-06-25T09:56:53.956804Z"
    },
    "papermill": {
     "duration": 0.053137,
     "end_time": "2024-06-25T09:56:53.961275",
     "exception": false,
     "start_time": "2024-06-25T09:56:53.908138",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels=c(\"Sunday\", \"Monday\", \"Tuesday\", \"Wednesday\", \"Thursday\", \"Friday\", \"Saturday\"))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6e98ce69",
   "metadata": {
    "papermill": {
     "duration": 0.021687,
     "end_time": "2024-06-25T09:56:54.004485",
     "exception": false,
     "start_time": "2024-06-25T09:56:53.982798",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Run the average ride time by each day for members vs casual users"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 43,
   "id": "0b90c7b3",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:54.052298Z",
     "iopub.status.busy": "2024-06-25T09:56:54.050655Z",
     "iopub.status.idle": "2024-06-25T09:56:54.552044Z",
     "shell.execute_reply": "2024-06-25T09:56:54.550279Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.528321,
     "end_time": "2024-06-25T09:56:54.554606",
     "exception": false,
     "start_time": "2024-06-25T09:56:54.026285",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 14 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$day_of_week</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>Sunday   </td><td>5061.3044</td></tr>\n",
       "\t<tr><td>member</td><td>Sunday   </td><td> 972.9383</td></tr>\n",
       "\t<tr><td>casual</td><td>Monday   </td><td>4752.0504</td></tr>\n",
       "\t<tr><td>member</td><td>Monday   </td><td> 822.3112</td></tr>\n",
       "\t<tr><td>casual</td><td>Tuesday  </td><td>4561.8039</td></tr>\n",
       "\t<tr><td>member</td><td>Tuesday  </td><td> 769.4416</td></tr>\n",
       "\t<tr><td>casual</td><td>Wednesday</td><td>4480.3724</td></tr>\n",
       "\t<tr><td>member</td><td>Wednesday</td><td> 711.9838</td></tr>\n",
       "\t<tr><td>casual</td><td>Thursday </td><td>8451.6669</td></tr>\n",
       "\t<tr><td>member</td><td>Thursday </td><td> 707.2093</td></tr>\n",
       "\t<tr><td>casual</td><td>Friday   </td><td>6090.7373</td></tr>\n",
       "\t<tr><td>member</td><td>Friday   </td><td> 796.7338</td></tr>\n",
       "\t<tr><td>casual</td><td>Saturday </td><td>4950.7708</td></tr>\n",
       "\t<tr><td>member</td><td>Saturday </td><td> 974.0730</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 14 × 3\n",
       "\\begin{tabular}{lll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$day\\_of\\_week & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <ord> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & Sunday    & 5061.3044\\\\\n",
       "\t member & Sunday    &  972.9383\\\\\n",
       "\t casual & Monday    & 4752.0504\\\\\n",
       "\t member & Monday    &  822.3112\\\\\n",
       "\t casual & Tuesday   & 4561.8039\\\\\n",
       "\t member & Tuesday   &  769.4416\\\\\n",
       "\t casual & Wednesday & 4480.3724\\\\\n",
       "\t member & Wednesday &  711.9838\\\\\n",
       "\t casual & Thursday  & 8451.6669\\\\\n",
       "\t member & Thursday  &  707.2093\\\\\n",
       "\t casual & Friday    & 6090.7373\\\\\n",
       "\t member & Friday    &  796.7338\\\\\n",
       "\t casual & Saturday  & 4950.7708\\\\\n",
       "\t member & Saturday  &  974.0730\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 14 × 3\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$day_of_week &lt;ord&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| casual | Sunday    | 5061.3044 |\n",
       "| member | Sunday    |  972.9383 |\n",
       "| casual | Monday    | 4752.0504 |\n",
       "| member | Monday    |  822.3112 |\n",
       "| casual | Tuesday   | 4561.8039 |\n",
       "| member | Tuesday   |  769.4416 |\n",
       "| casual | Wednesday | 4480.3724 |\n",
       "| member | Wednesday |  711.9838 |\n",
       "| casual | Thursday  | 8451.6669 |\n",
       "| member | Thursday  |  707.2093 |\n",
       "| casual | Friday    | 6090.7373 |\n",
       "| member | Friday    |  796.7338 |\n",
       "| casual | Saturday  | 4950.7708 |\n",
       "| member | Saturday  |  974.0730 |\n",
       "\n"
      ],
      "text/plain": [
       "   all_trips_v2$member_casual all_trips_v2$day_of_week all_trips_v2$ride_length\n",
       "1  casual                     Sunday                   5061.3044               \n",
       "2  member                     Sunday                    972.9383               \n",
       "3  casual                     Monday                   4752.0504               \n",
       "4  member                     Monday                    822.3112               \n",
       "5  casual                     Tuesday                  4561.8039               \n",
       "6  member                     Tuesday                   769.4416               \n",
       "7  casual                     Wednesday                4480.3724               \n",
       "8  member                     Wednesday                 711.9838               \n",
       "9  casual                     Thursday                 8451.6669               \n",
       "10 member                     Thursday                  707.2093               \n",
       "11 casual                     Friday                   6090.7373               \n",
       "12 member                     Friday                    796.7338               \n",
       "13 casual                     Saturday                 4950.7708               \n",
       "14 member                     Saturday                  974.0730               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "e15fe44b",
   "metadata": {
    "papermill": {
     "duration": 0.022318,
     "end_time": "2024-06-25T09:56:54.599374",
     "exception": false,
     "start_time": "2024-06-25T09:56:54.577056",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Analyze ridership data by type and weekday**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 44,
   "id": "ad4db553",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:54.647337Z",
     "iopub.status.busy": "2024-06-25T09:56:54.645686Z",
     "iopub.status.idle": "2024-06-25T09:56:55.525568Z",
     "shell.execute_reply": "2024-06-25T09:56:55.523785Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.906332,
     "end_time": "2024-06-25T09:56:55.527972",
     "exception": false,
     "start_time": "2024-06-25T09:56:54.621640",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'member_casual'. You can override using the\n",
      "`.groups` argument.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 14 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>member_casual</th><th scope=col>weekday</th><th scope=col>number_of_rides</th><th scope=col>average_duration</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>Sun</td><td> 18652</td><td>5061.3044</td></tr>\n",
       "\t<tr><td>casual</td><td>Mon</td><td>  5591</td><td>4752.0504</td></tr>\n",
       "\t<tr><td>casual</td><td>Tue</td><td>  7311</td><td>4561.8039</td></tr>\n",
       "\t<tr><td>casual</td><td>Wed</td><td>  7690</td><td>4480.3724</td></tr>\n",
       "\t<tr><td>casual</td><td>Thu</td><td>  7147</td><td>8451.6669</td></tr>\n",
       "\t<tr><td>casual</td><td>Fri</td><td>  8013</td><td>6090.7373</td></tr>\n",
       "\t<tr><td>casual</td><td>Sat</td><td> 13473</td><td>4950.7708</td></tr>\n",
       "\t<tr><td>member</td><td>Sun</td><td> 60197</td><td> 972.9383</td></tr>\n",
       "\t<tr><td>member</td><td>Mon</td><td>110430</td><td> 822.3112</td></tr>\n",
       "\t<tr><td>member</td><td>Tue</td><td>127974</td><td> 769.4416</td></tr>\n",
       "\t<tr><td>member</td><td>Wed</td><td>121902</td><td> 711.9838</td></tr>\n",
       "\t<tr><td>member</td><td>Thu</td><td>125228</td><td> 707.2093</td></tr>\n",
       "\t<tr><td>member</td><td>Fri</td><td>115168</td><td> 796.7338</td></tr>\n",
       "\t<tr><td>member</td><td>Sat</td><td> 59413</td><td> 974.0730</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 14 × 4\n",
       "\\begin{tabular}{llll}\n",
       " member\\_casual & weekday & number\\_of\\_rides & average\\_duration\\\\\n",
       " <chr> & <ord> & <int> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & Sun &  18652 & 5061.3044\\\\\n",
       "\t casual & Mon &   5591 & 4752.0504\\\\\n",
       "\t casual & Tue &   7311 & 4561.8039\\\\\n",
       "\t casual & Wed &   7690 & 4480.3724\\\\\n",
       "\t casual & Thu &   7147 & 8451.6669\\\\\n",
       "\t casual & Fri &   8013 & 6090.7373\\\\\n",
       "\t casual & Sat &  13473 & 4950.7708\\\\\n",
       "\t member & Sun &  60197 &  972.9383\\\\\n",
       "\t member & Mon & 110430 &  822.3112\\\\\n",
       "\t member & Tue & 127974 &  769.4416\\\\\n",
       "\t member & Wed & 121902 &  711.9838\\\\\n",
       "\t member & Thu & 125228 &  707.2093\\\\\n",
       "\t member & Fri & 115168 &  796.7338\\\\\n",
       "\t member & Sat &  59413 &  974.0730\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 14 × 4\n",
       "\n",
       "| member_casual &lt;chr&gt; | weekday &lt;ord&gt; | number_of_rides &lt;int&gt; | average_duration &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| casual | Sun |  18652 | 5061.3044 |\n",
       "| casual | Mon |   5591 | 4752.0504 |\n",
       "| casual | Tue |   7311 | 4561.8039 |\n",
       "| casual | Wed |   7690 | 4480.3724 |\n",
       "| casual | Thu |   7147 | 8451.6669 |\n",
       "| casual | Fri |   8013 | 6090.7373 |\n",
       "| casual | Sat |  13473 | 4950.7708 |\n",
       "| member | Sun |  60197 |  972.9383 |\n",
       "| member | Mon | 110430 |  822.3112 |\n",
       "| member | Tue | 127974 |  769.4416 |\n",
       "| member | Wed | 121902 |  711.9838 |\n",
       "| member | Thu | 125228 |  707.2093 |\n",
       "| member | Fri | 115168 |  796.7338 |\n",
       "| member | Sat |  59413 |  974.0730 |\n",
       "\n"
      ],
      "text/plain": [
       "   member_casual weekday number_of_rides average_duration\n",
       "1  casual        Sun      18652          5061.3044       \n",
       "2  casual        Mon       5591          4752.0504       \n",
       "3  casual        Tue       7311          4561.8039       \n",
       "4  casual        Wed       7690          4480.3724       \n",
       "5  casual        Thu       7147          8451.6669       \n",
       "6  casual        Fri       8013          6090.7373       \n",
       "7  casual        Sat      13473          4950.7708       \n",
       "8  member        Sun      60197           972.9383       \n",
       "9  member        Mon     110430           822.3112       \n",
       "10 member        Tue     127974           769.4416       \n",
       "11 member        Wed     121902           711.9838       \n",
       "12 member        Thu     125228           707.2093       \n",
       "13 member        Fri     115168           796.7338       \n",
       "14 member        Sat      59413           974.0730       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "all_trips_v2 %>% \n",
    "  mutate(weekday = wday(started_at, label = TRUE)) %>% \n",
    "  group_by(member_casual, weekday) %>% \n",
    "  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% \n",
    "  arrange(member_casual, weekday)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "4855ff88",
   "metadata": {
    "papermill": {
     "duration": 0.022277,
     "end_time": "2024-06-25T09:56:55.572524",
     "exception": false,
     "start_time": "2024-06-25T09:56:55.550247",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Let's visualize the number of rides by rider type"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 45,
   "id": "e6cdc6b6",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:55.621084Z",
     "iopub.status.busy": "2024-06-25T09:56:55.619406Z",
     "iopub.status.idle": "2024-06-25T09:56:57.084313Z",
     "shell.execute_reply": "2024-06-25T09:56:57.082510Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 1.491615,
     "end_time": "2024-06-25T09:56:57.086666",
     "exception": false,
     "start_time": "2024-06-25T09:56:55.595051",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'member_casual'. You can override using the\n",
      "`.groups` argument.\n"
     ]
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzdZ2CV5d3A4ftk7wQIQxEXuHGgtmodOFDrqBariLNqcdRdJ4obR9VX3Iql7lrF\nLVpq66iiuEfduHAgqCASdvZ5P8RGqjScQHJOvHNdn3JGnvt/J4g/nrMSyWQyAADw05eV6QEA\nAGgbwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBI5mR4gY2bNmpXpEb5XUFCQ\nn5/f0NAwb968TM+SJoWFhXl5efX19fPnz8/0LGnSCbdcVFSUm5tbV1e3YMGCTM+SJp1wy8XF\nxTk5ObW1tQsXLsz0LGnSYbfcpUuXTI9A5nXesGtsbOxQn7qRlZXV2NjY0NCQ6UHSJysrK5FI\ndJ4tJxKJzrbl0Fl/yyGEzrZlv2XoIDwUCwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEImcTA8AnUjiqYnpXG5G/zXSuRwAGeeMHQBAJIQd\nAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSE\nHQBAJIQdAEAkcjI9AEBUEk9NTOdyM/qvkc7lgA6u84ZdeXl5pkf4XlZWVgghOzu7oqIi07Ok\nSdOWc3JyOs+Ws7Oz07xixn+2TVvOzc3N+CRp02l/y3l5eRmfJG065parqqoyPQIdQucNu+rq\n6kyP8L38/PysrKxkMtmhpmpXTVtubGzsPFsuKChI84oZ/9kWFBTk5OQ0NDRkfJK06YS/5cLC\nwuzs7E71W27eck1NTaZngR/qvGFXU1OTTCYzPcV3srOzc3NzO1Xl5OTkdLYt5+bmpnnFjP9s\nc3Nzc3JyOtVvOS8vL80rZvxnm5+f39nCrhNumZ8QL54AAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiEROpgcAYpZ4\n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\n0v2iPACATEl0nOeZpVkHfI5dfX19VVVVpmdJk5KSksIXXk3zojP6r5HmFRdVWlpa8Pwr6Vwx\ns/sNnXLLZWVl+c+9nM4VM77l8vLyvIkvpXPFjrDl3Nzc6urqjvYcu8rKykyPQOZl8qFYAADa\nkLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIhEq8Ku8cvJHzZ9VT395bNPPurYEX98bPLc9hgLAIDWyknxfrWzn993y13H\nfdyrdv47yfpZu6898J8zF4YQrh91wy3vv7XfiiXtOSQAAEuW6hm7u3691wPv1v72hGNCCNNf\nPf6fMxceNf6DWZ88s2HutJP2vrs9JwQAICWpht2FL01fabexY0YeEUJ48/wJ+eVbXrnTahUr\nb3Hl/v1mvjWqPScEACAlqYbd5zX1lZv1afr61pdmdFvvhOwQQgjFqxbXL/y4fWYDAKAVUg27\n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\na+pCCPXVNSGE6urqpluz8otCCN/WNfbK++4hnm/qGnK65IQQpr9w7U3v9hp9y9b/a4yhQ4du\nv/32zRcXLly4cOHCttrjMiosLEz/olVVVelftFlRUdGS79TWOtuWM7vfEEJxcbpflm7L6VdS\nUpLmFW0ZWpCZZyps1KPwyVkzcorzEtnF99x926LPVkgkskMIC2bcOXTY3c1XDhkypOmLUWN+\nH8LTkxbW9cr77lHUDxbWl69THkKY8cybtXO/POQ3v27+rr8dts9jxevfe+fIpos9evTo0aNH\n860zZ85MJjvKG901NmbgNbyZfUJGJ9xy+v+8Zfw5N+n/LWd8y53wt2zLaZDxLfMTko6wq/rg\n2hMveffC667u2XSaLdnw9JcLKjZcvahnn9D40vgZdb/+7kl1yZvOHD574HF/GLR8UY/9x43b\nP4RQv3DSnvt9/xy7kKzrnfen8c/N2HqnFUIIdfNee2Vu7Z7b9Aoh9D3w9FGDv3tMNtk458ST\nztl8xAV79eiWhg0CAHQE6Qi7slX37rbgiFPPveHofbYrTyx45Z+3T5hfetaw1fNKcodt0O3W\nU0cWHLbnmr1L/v3YTQ+/N/Oc4d1bOlYi98Q91zz5xnOe7HnKmhU1D109qrj39gcsXxxCKOi5\nUr+e392r6Tl2FSutuqo3KAYAOo10hF1WTuXIa8+9efQdV55/enVO2ar9+p96xXkDSnJDCLue\ndXnNn665Z/TFs+pye6+y3gkXjVi/OLflo/Xb+/wja67466gzZ1Yn+q4/cOSJh6b7decAAB1S\nouM8zyzNOtRz7IqLi4tefC3Ni87ov0aaV1xUSUlJ4QuvpnnRzG65tLS04PlX0rliZvcbOuWW\ny8rK8p97OZ0rZnzL5eXleRNfSueKtvy/VFZWtvckdHwZeJNYAADag7ADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIRE6mB8iYioqKTI/wvaysDBR2\nly5d0r9oM1tOg8zuN9hyWthy+nXMLc+aNSsNk9Dxdd6wW7BgQaZH+F5+fn76F83sT6CgoCD9\ni3a2LWf8D3lhYWGaV7Tl9OuEWy4qKkrzihnfMj8hnTfsamtrk8lkpqf4Tk5OBn4RNTU16V+0\nWW5ubvoXzeyW8/Ly0rxiZvcbOuWW0/+PtIxvOf3/YrFlaIHn2AEARELYAQBEQtgBAERC2AEA\nRELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgB\nAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELY\nAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEIifTA3RopZeel77Fdto7fWsBADFy\nxg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBI5mR4AAJZV6aXnpW2txhDCTnunbTlo\nFWfsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewA\nACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHs\nAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACKRk+kBAGh7pZeel56FGkMI\nO+2dnrWAJXLGDgAgEs7YQaeTtnM5ITiXA5BWztgBAETCGTs6O6evAIiGsAPil7Z8Twb5DmSS\nh2IBACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACLhfez4L96tFwB+upyxAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIRE66Fmp86q7rHp7w2pS52Wv13+SgYw9epTC7HQ7VhqsAAPzEpOmM3eT7zrh8\n7POb7XHo2ccfWPTx4yNOGJNsh0O14SoAAD85aQm7ZO2ose/1O+D8PQdtts5GWx5/8VHzpo6/\n88v5bXyoNlwFAOAnKB1hVzN7wufVDTttu3zTxfwuW65fkvfy01+HEBrrZ95z/YXDDhi6x5B9\njznt4icmzfrB9yaTNZ9+OiWVQ7VwEwBAZ5CO59jVzn8zhLB20fdrrVOU88+3Z4cQbh9+/D9r\n+h963Ig+ZYlJzz1y1fDDG667ZYfli5rv2VD9yfEnXPTg/bcu8VAt3NRk/PjxEyZMaL545pln\n5uSk7SmGHVFpaWmmR0i3zrblzrbfYMudgy0v1ty5c9MwCR1fOsqmsWZ+CKEy9/vXMVTmZtfN\nqaue+eD9H8658M4T1ynKCSH0Xb1//Uv73XX9uzuM3Li1h2r5piYfffTR448/3nzx3HPPzc/P\nb3nymlS3+JO02O3bckz+159wW46JLTeJeL/hf/+WFyXsaJKOsMvKLwohfFvX2Cvvu0d+v6lr\nyOmSM++L15PJ5GlD91j0zsX1X4SwcUg2VNfUhRDqq2tCCNXV1S0fquWbmvTr12/QoEHNF+vr\n65c8+nmXLs2GWy8nJyeZnZ1MJmtra9OzYgihpmZxfxOmd8uNjY11dXVLvncb6WxbXvx+Q/q2\nnJubm8zKsuV21UG23NDQkNJfqm0hs/8hh46zZVicdIRdbtG6ITw9aWFdr7zv/s3xwcL68nXK\nc4rzEtnF99x9W2KROycS2SGEBTPuHDrs7uYrhwwZ0vTFqDG/X+yhWlil+SA777zzzjvv3Hxx\n5syZyWRHedVscXFxYWFhQ0ND5/knV0lJSXZ2dqfacmlpaSfccn5+fn19fefZcllZWV5eXl1d\nXefZcnl5eVZWVqf6LTdtua6ubt68eZmeBX4oHS+eKKjYpnde9vjnZjRdrJv32itzazfcpldR\nzx1D44LxM+pyv5Nz+3lnXP3UVyGEoh77jxs3bty4cfePvSQrp8u4/+jXY9BiD9XCKmnYIABA\nR5CWtztJ5J6455of3njOk699MG3yW38+c1Rx7+0PWL44r3TjYRt0+8upIx995tVPJ7//4A3D\nH35v5rabdV+KQy3hJgCATiBNLwvtt/f5R9Zc8ddRZ86sTvRdf+DIEw9tevh117Mur/nTNfeM\nvnhWXW7vVdY74aIR6xfnLt2hWr4JACB6iY7zPLM064DPsauvr6+qqsr0LGlSUlJSUFBQV1c3\ne/bsJd87Ck1POOuEW66trZ0zZ06mZ0mTpufY1dTUdKonnOXm5nbCLVdXV3e059hVVlZmegQy\nL00fKQYAQHsTdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQ\ndgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACR\nEHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJFIJJPJTM+QGTNnzuw4e58xY8as\nWbMKCwv79OmT6VnSZPr06VVVVZ1qy19//fXs2bOLi4t79+6d6VnS5KuvvpozZ05JScnyyy+f\n6VnSZNq0afPmzSsrK+vVq1emZ0mTqVOnzp8/v7y8vGfPnpmeJU2mTJmycOHCioqKHj16ZHqW\n/1JZWZnpEci8zht2Hcqll146duzYtdde+7bbbsv0LGlywQUXPPDAAwMGDBgzZkymZ0mTs846\na/z48Ztsssm1116b6VnSZPjw4Y8//vhWW201atSoTM+SJieccMKECRMGDRr0xz/+MdOzpMlR\nRx314osv7rzzzuedd16mZ0mTQw899PXXXx88ePCIESMyPQv8kIdiAQAiIewAACIh7AAAIuE5\n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\nRU5ErkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "all_trips_v2 %>% \n",
    "  mutate(weekday = wday(started_at, label = TRUE)) %>% \n",
    "  group_by(member_casual, weekday) %>% \n",
    "  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% \n",
    "  arrange(member_casual, weekday)  %>% \n",
    "  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +\n",
    "  geom_col(position = \"dodge\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "abfdef9d",
   "metadata": {
    "papermill": {
     "duration": 0.023186,
     "end_time": "2024-06-25T09:56:57.133346",
     "exception": false,
     "start_time": "2024-06-25T09:56:57.110160",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "* Let's create a visualization for average duration"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 46,
   "id": "a9e5051e",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2024-06-25T09:56:57.184355Z",
     "iopub.status.busy": "2024-06-25T09:56:57.182602Z",
     "iopub.status.idle": "2024-06-25T09:56:58.392977Z",
     "shell.execute_reply": "2024-06-25T09:56:58.390052Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 1.239396,
     "end_time": "2024-06-25T09:56:58.396138",
     "exception": false,
     "start_time": "2024-06-25T09:56:57.156742",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'member_casual'. You can override using the\n",
      "`.groups` argument.\n"
     ]
    },
    {
     "data": {
      "image/png": "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\n9gXHujP2bNuRGt+4WY+BT/QY+ISI7PpyfL0Ozz06evvOOS38c79wrJNbk/N+dqVvLvzkRaU1\n7DrdPcpbrsqcYV3mPGYvV76M/eJrmwcOHPgHcwB0EjlpnJ7DOUVsL8/Qc0QACBazvcbYenHP\nv99nzfM/3Zx4Lq0WDr29zzv73j2RUbxzZhybPfKL4RM7VhcREc+HT9ye4fH2euW6QAwXVfWZ\nxhHTvn/kiQO3fVzNbhIR19lNvV+d76w1OTdrt8fni2vSLO/OWcc3TjmaLpZzF94yT8655ppX\nm475YdvYq/1brrjqahHJzcwVEYfJmHPqi9PuSQkWo4jknNk8ZO3RvFNd9uRFpTXs7Ha7SIWO\nHf9+wRMAAEBEhq2cPb9Wz/ZJDbr06NysZtyvaxe/v2pvw77v9ypbzCt2tjL2lzrX+7Xn/Vcn\nRW7/5qNP1x+s3G78ay3KBWI4gyl6+YIhNbu82rBGq373tUu0pH46f+5xT/hrS/o6ytjbxA/5\nZlKnhyxPNKvk2L9j8xtzP0tKtLsOb5vxwccP3NMt+orn25R5fc34Gzrs73dN/ere1IPL3njL\nZIkfO7GpiHTuVev5CVsa39T7qftucp/Y/c7UV08mWOVIrn9cR5kehZ+8qAvRGnYrVqwo6qkB\nAEDoiKhy988/R48Y8eLyT95c5rJWr1VvzPwvRz9wa7FP2Hz6xt5758x679NVC5MjK9S+f/T8\naWMfyHsRXIkPV/X2abtW1nl84qz3Zo53GiLqN7/t3QnT76sVIyLLtq8YOnDUsplj3reUu7LZ\ntfO37r8m+42r2459cvDQO+/qGm6N/uyX1SMeHbP8yw9WfZAZFlv+ypb3Lhnz8h2VIkSk6fPr\nZmX1n7l0zZMPfuj2+Spe1/s/k05df+2X50Y12gs/eVFXYfD5NF3rO3v2bCF7o6OjizqwPlJT\nU3Nzcwu/j85Pz4mIYfzktLQ0nQf9G/1XbXlxenJy8uXvF0j6r9r28ozk5GSv13v5uyrBaDTG\nxcWJSFpamsvlCu5k9P/l9ox5KSurmJ9QUFL0X7WMm5Senq73oBfTf9XmidNSUlJ0HvSyEhIS\ngj0FFMbrTDtyKrdKpbiAjqL1il1MTGHvu9VYhwAAAKHJaIuqUingo2gNu7Fjx15025d7bP/O\nZYuXJxsqjp0zscSnBQAAUCIOftqp6f3fFXIHW3SrEweX6TafgNIadmPGjI8dpK4AACAASURB\n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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "all_trips_v2 %>% \n",
    "  mutate(weekday = wday(started_at, label = TRUE)) %>% \n",
    "  group_by(member_casual, weekday) %>% \n",
    "  summarise(number_of_rides = n()\n",
    "            ,average_duration = mean(ride_length)) %>% \n",
    "  arrange(member_casual, weekday)  %>% \n",
    "  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +\n",
    "  geom_col(position = \"dodge\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d4e7166f",
   "metadata": {
    "papermill": {
     "duration": 0.023727,
     "end_time": "2024-06-25T09:56:58.443846",
     "exception": false,
     "start_time": "2024-06-25T09:56:58.420119",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Key Findings\n",
    "Based on the given data, here are the insights and observations about the usage patterns of Cyclistic bike rides:\n",
    "\n",
    "### 1. Usage Frequency\n",
    "- **Annual Members**: Annual members make up approximately 91% of the total rides.\n",
    "- **Casual Riders**: Casual riders account for around 9% of the total rides.\n",
    "- **Interpretation**: The majority of Cyclistic users are annual members, indicating a preference for membership among frequent riders.\n",
    "\n",
    "### 2. Ride Duration\n",
    "- **Casual Riders**: Casual riders account for approximately 87% of the total ride duration.\n",
    "- **Annual Members**: Annual members make up about 13% of the total ride duration.\n",
    "- **Interpretation**: Despite being fewer in number, casual riders tend to take longer rides compared to annual members. This could imply that casual riders use Cyclistic bikes for more leisurely or exploratory purposes, while annual members might use them for shorter, possibly more routine commutes.\n",
    "\n",
    "### 3. Day-Specific Patterns\n",
    "- **Highest Number of Rides**: The highest number of rides occurs on **Tuesdays**, with a total of 127,974 rides.\n",
    "- **Highest Ride Duration**: The highest ride duration occurs on **Thursdays**, with an average duration of 8,451.67 seconds (approximately 2 hours and 21 minutes).\n",
    "- **Interpretation**: \n",
    "  - **Tuesdays**: The high number of rides on Tuesdays could suggest that people are more active during the early part of the week, possibly due to work-related commutes or early-week errands.\n",
    "  - **Thursdays**: The longer ride durations on Thursdays might indicate that users are taking longer trips as the week progresses, perhaps combining commuting with social activities or leisure before the weekend.\n",
    "\n",
    "### Summary\n",
    "- **Annual Members** dominate in terms of ride frequency, suggesting regular and consistent use, likely for commuting or routine activities.\n",
    "- **Casual Riders** take significantly longer rides, indicating their rides are more likely for leisure or exploration.\n",
    "- **Tuesdays** and **Thursdays** show distinct patterns in ride numbers and durations, respectively, which could help Cyclistic in planning promotions or maintenance schedules.\n",
    "\n",
    "These insights can help Cyclistic tailor its services and marketing strategies to better cater to the needs of both annual members and casual riders, as well as optimize bike availability and maintenance schedules based on day-specific usage patterns.\n",
    "\n",
    "\n",
    "## Recommendation\n",
    "Based on the observations, here are three recommendations for Cyclistic:\n",
    "\n",
    "### 1. **Enhance Membership Benefits and Marketing**\n",
    "Given that annual members constitute 91% of the rides, Cyclistic should focus on:\n",
    "- **Loyalty Programs**: Introduce or enhance loyalty programs that reward frequent riders. Benefits could include discounts, exclusive access to new bike models, or priority booking.\n",
    "- **Referral Incentives**: Encourage existing members to refer new members by offering incentives such as free ride time or discounts on annual renewals.\n",
    "- **Targeted Marketing**: Run marketing campaigns targeting potential annual members, highlighting the cost-effectiveness and convenience of an annual membership for regular commuters.\n",
    "\n",
    "### 2. **Promote Casual Riding for Leisure and Exploration**\n",
    "Since casual riders tend to take longer rides, Cyclistic can:\n",
    "- **Leisure Ride Packages**: Offer packages tailored for casual riders, such as day passes or weekend specials, that cater to tourists and occasional users.\n",
    "- **Tourism Partnerships**: Collaborate with local tourism boards and attractions to create guided bike tours or special offers that encourage tourists to explore the city using Cyclistic bikes.\n",
    "- **Enhance Ride Experience**: Improve bike comfort and introduce features appealing to leisure riders, such as better seats, bike baskets, or GPS-enabled bikes for easier navigation.\n",
    "\n",
    "### 3. **Optimize Bike Availability and Maintenance Schedules**\n",
    "Given the distinct usage patterns on different days:\n",
    "- **Tuesdays**: Increase bike availability and ensure sufficient maintenance staff on Mondays to prepare for the high demand on Tuesdays. This could include redistributing bikes to high-traffic areas.\n",
    "- **Thursdays**: Since Thursdays see the longest ride durations, ensure bikes are well-maintained and in top condition mid-week to handle these longer rides. Additionally, consider providing special offers or discounts for long-duration rentals on Thursdays.\n",
    "- **Data-Driven Planning**: Continuously analyze ride data to identify other trends and adjust bike distribution and maintenance schedules accordingly. Implement predictive maintenance to reduce downtime and improve the overall user experience.\n",
    "\n",
    "### Summary\n",
    "By focusing on these strategies, Cyclistic can enhance member satisfaction, attract more casual riders, and ensure optimal bike availability and maintenance, ultimately driving higher usage and better service quality."
   ]
  }
 ],
 "metadata": {
  "kaggle": {
   "accelerator": "none",
   "dataSources": [
    {
     "datasetId": 5261827,
     "sourceId": 8758335,
     "sourceType": "datasetVersion"
    }
   ],
   "dockerImageVersionId": 30618,
   "isGpuEnabled": false,
   "isInternetEnabled": true,
   "language": "r",
   "sourceType": "notebook"
  },
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 42.754026,
   "end_time": "2024-06-25T09:56:58.589427",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2024-06-25T09:56:15.835401",
   "version": "2.5.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
