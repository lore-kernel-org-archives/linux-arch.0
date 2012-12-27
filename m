From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RESEND PATCH] modpost: For ARC Port submission
Date: Thu, 27 Dec 2012 16:17:19 +0530
Message-ID: <1356605240-4555-1-git-send-email-vgupta@synopsys.com>
References: <1352720953-24321-21-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352720953-24321-21-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Hi,

This is following up on ARC Linux Port submission bits:
Basic Port: https://lkml.org/lkml/2012/11/7/114
Addons:     https://lkml.org/lkml/2012/11/12/121

I'm resending this single patch to hopefully get ACK on simple modpost change.

Thx,
-Vineet

Vineet Gupta (1):
  modpost: Ignore ARC specific non-alloc sections

 scripts/mod/modpost.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

-- 
1.7.4.1
