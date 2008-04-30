From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 2/10] x86: convert to generic helpers for IPI function
 calls
Date: Wed, 30 Apr 2008 14:39:10 -0700
Message-ID: <4818E6FE.50607@goop.org>
References: <1209453990-7735-1-git-send-email-jens.axboe@oracle.com> <1209453990-7735-3-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1209453990-7735-3-git-send-email-jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org

Jens Axboe wrote:
> This converts x86, x86-64, and xen to use the new helpers for
> smp_call_function() and friends, and adds support for
> smp_call_function_single().
>   
Seems to work fine with this:

Subject: xen: build fix for generic IPI stuff

Not even one CONFIG_XEN test build?

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
---
 arch/x86/xen/smp.c           |    3 +--
 include/asm-x86/xen/events.h |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

===================================================================
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -43,8 +43,7 @@
 static DEFINE_PER_CPU(int, debug_irq) = -1;
 
 static irqreturn_t xen_call_function_interrupt(int irq, void *dev_id);
-
-static struct call_data_struct *call_data;
+static irqreturn_t xen_call_function_single_interrupt(int irq, void *dev_id);
 
 /*
  * Reschedule call back. Nothing to do,
===================================================================
--- a/include/asm-x86/xen/events.h
+++ b/include/asm-x86/xen/events.h
@@ -4,6 +4,7 @@
 enum ipi_vector {
 	XEN_RESCHEDULE_VECTOR,
 	XEN_CALL_FUNCTION_VECTOR,
+	XEN_CALL_FUNCTION_SINGLE_VECTOR,
 
 	XEN_NR_IPIS,
 };
