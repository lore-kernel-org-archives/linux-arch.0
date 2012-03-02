Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:42865 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755974Ab2CBFx6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 2 Mar 2012 00:53:58 -0500
Message-ID: <4F50603B.7040505@zytor.com>
Date: Thu, 01 Mar 2012 21:52:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v12 06/13] seccomp: add system call filtering using BPF
References: <1330559620-23543-1-git-send-email-wad@chromium.org>    <1330559620-23543-6-git-send-email-wad@chromium.org> <a6fdbe9d1daf6864589c9affc7048965.squirrel@webmail.greenhost.nl>
In-Reply-To: <a6fdbe9d1daf6864589c9affc7048965.squirrel@webmail.greenhost.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Indan Zupancic <indan@nul.nu>
Cc: Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, pmoore@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, keescook@chromium.org
Message-ID: <20120302055259.6I2MC0jU1HDZEtpU2Wme3mRedmyHKyu4JX8gcVU6-Wo@z>

On 03/01/2012 09:45 PM, Indan Zupancic wrote:
> 
>> + * @nr: the system call number
>> + * @arch: indicates system call convention as an AUDIT_ARCH_* value
>> + *        as defined in <linux/audit.h>.
>> + * @instruction_pointer: at the time of the system call.
> 
> If the vDSO is used this will always be the same, so what good is this?
> I haven't gotten an answer to this yet.
> 

And if it isn't, or you're on an architecture which doesn't use the vdso
as the launching point, it's not. You seem to be unable to look outside
your own particular use cases, but it is very likely that the same
oddball cases which do mixed-mode programming are ones for which this
kind of filtering facility would be extremely useful -- Pin is a great
example.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

