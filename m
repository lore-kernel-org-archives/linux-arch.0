Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:46292 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932877AbYBGTM4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 7 Feb 2008 14:12:56 -0500
Message-ID: <47AB5831.1070602@redhat.com>
Date: Thu, 07 Feb 2008 14:12:49 -0500
From: Masami Hiramatsu <mhiramat@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] kprobe: remove preempt_enable/disable from	kprobe_handle_fault()
References: <1202007626.1844.46.camel@brick>
In-Reply-To: <1202007626.1844.46.camel@brick>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Harvey Harrison wrote:
> This patch removes the preempt_disable/enable pair around kprobe_running
> which was originally added to avoid the assertion from smp_processor_id
> which would be hit an asertion if preemption was enabled.
> 
> Kprobes can not be running if we are preemptible, so test explicitly
> for preemption and bail out before hitting kprobe_running().
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>

Acked-by: Masami Hiramatsu <mhiramat@redhat.com>


-- 
Masami Hiramatsu

Software Engineer
Hitachi Computer Products (America) Inc.
Software Solutions Division

e-mail: mhiramat@redhat.com


