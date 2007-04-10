Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58958 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932344AbXDJAgl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Apr 2007 20:36:41 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC, PATCH 1/3] introduce SYS_CLONE_MASK
References: <20070409020600.6338BD82F4@pipsqueak.sf.frob.com>
	<m11wit34fo.fsf@ebiederm.dsl.xmission.com>
	<20070409173053.GD22997@lnx-holt.americas.sgi.com>
Date: Mon, 09 Apr 2007 18:35:39 -0600
In-Reply-To: <20070409173053.GD22997@lnx-holt.americas.sgi.com> (Robin Holt's
	message of "Mon, 9 Apr 2007 12:30:53 -0500")
Message-ID: <m1r6qtyskk.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Robin Holt <holt@sgi.com>
Cc: Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@linux-foundation.org>, Davide Libenzi <davidel@xmailserver.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Robin Holt <holt@sgi.com> writes:

> OK.  I just got the OK from management.  The system we were booting was
> for research only.  We had NR_CPUS=num_online_cpus()=4096 which were
> non-hyperthreaded.  With no attached I/O and the tweak I originally
> posted plus one change Jack has already gotten accepted, the machine
> booted in approx 12 minutes.

How much of that time was between the time the kernel was loaded
and before user space was started?

Twelve minutes sounds like a long time for a boot, if you aren't fsck'ing
filesystems.

Eric
