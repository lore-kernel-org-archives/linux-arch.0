Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:2863 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbXH0SCR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 27 Aug 2007 14:02:17 -0400
Subject: Re: [PATCH] Use helpers to obtain task pid in printks (arch code)
From: Joe Perches <joe@perches.com>
In-Reply-To: <46D27D7E.7090806@openvz.org>
References: <46D27D7E.7090806@openvz.org>
Content-Type: text/plain
Date: Mon, 27 Aug 2007 11:01:48 -0700
Message-Id: <1188237708.18004.102.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Pavel Emelyanov <xemul@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@openvz.org>, Linux Containers <containers@lists.osdl.org>, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sukadev Bhattiprolu <sukadev@us.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2007-08-27 at 11:30 +0400, Pavel Emelyanov wrote:
> From: Alexey Dobriyan <adobriyan@openvz.org>
> 
> One of the easiest things to isolate is the pid printed in kernel
> log. There was a patch, that made this for arch-independent code,
> this one makes so for arch/xxx files.

Perhaps it would be worthwhile to standardize the printk
task information content? Maybe a format knob?

Maybe TASK_FMT/TASK_ARG(task)

#define TASK_FMT "%s"
#define TASK_ARG(tsk) ({char __buf[MAX_TASK_INFO]; print_task(tsk, buf, sizeof(__buf)); __buf})

char* print_task(const struct task_struct* tsk, char* buf, size_t size)
{
	char* p = buf;
	int task_knob = get_task_knob();
	*p++ = '[';
	if (task_knob & feature)
		p += snprintf(p, size - (p - buf), fmt, feature);
	[...]
	*p++ = ']';
	return buf;
}
EXPORT_SYMBOL(print_task)


