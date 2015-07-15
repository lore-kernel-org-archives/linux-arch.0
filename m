From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 0/2] perf/urgent fixes
Date: Wed, 15 Jul 2015 12:20:06 -0300
Message-ID: <1436973608-9271-1-git-send-email-acme@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:37852 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbbGOPU2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2015 11:20:28 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Brodkin <abrodkin@synopsys.com>, David Ahern <dsahern@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Jiri Olsa <jolsa@redhat.com>, linux-arch@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Vineet Gupta <vgupta@synopsys.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Ingo,

	Please consider pulling,

- Arnaldo

The following changes since commit 65ea03e31e5ab47f784b1a701419264af97d3205:

  Merge tag 'perf-urgent-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2015-07-15 13:31:21 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo

for you to fetch changes up to 3c71ba3f80bbd476bbfb2a008da9b676031cbd32:

  perf tools: Really allow to specify custom CC, AR or LD (2015-07-15 11:57:28 -0300)

----------------------------------------------------------------
perf/urgent fixes:

User visible:

- Fix misplaced check for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT in
  the auxtrace code, which made 'perf record' fail straight away
  in some architectures, even when auxtrace wasn't involved. (Adrian Hunter)

Developer stuff:

- Really allow to specify custom CC, AR or LD (Alexey Brodkin)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf auxtrace: Fix misplaced check for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT

Alexey Brodkin (1):
      perf tools: Really allow to specify custom CC, AR or LD

 tools/perf/Makefile.perf   | 19 ++++++++++++++++---
 tools/perf/util/auxtrace.c | 10 +++++-----
 2 files changed, 21 insertions(+), 8 deletions(-)
