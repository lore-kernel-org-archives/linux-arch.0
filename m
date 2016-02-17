Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36552 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934355AbcBQQl7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2016 11:41:59 -0500
Date: Wed, 17 Feb 2016 17:41:56 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: [RFC 11/12 v1] x86, rwsem: provide __down_write_killable
Message-ID: <20160217164156.GU29196@dhcp22.suse.cz>
References: <1454444369-2146-1-git-send-email-mhocko@kernel.org>
 <1454444369-2146-12-git-send-email-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454444369-2146-12-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Message-ID: <20160217164156.pyoNPRGF9S1Hr9mmIqgE8bR0pmYINpmAfC2fvyO8Iac@z>

OK, so I have dropped patch 10 and reworked the x86 part to use the same
asm as __down_write uses. Does this look any better?

I am not an expert in inline asm so the way I am doing it might be not
optimal but at least the gerenated code looks sane (no changes for the
regular __down_write).
---
