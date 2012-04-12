Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39841 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762166Ab2DLWL4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Apr 2012 18:11:56 -0400
Received: by bkcik5 with SMTP id ik5so1883812bkc.19
        for <linux-arch@vger.kernel.org>; Thu, 12 Apr 2012 15:11:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1334267284-19166-15-git-send-email-wad@chromium.org>
References: <1334267284-19166-1-git-send-email-wad@chromium.org>
	<1334267284-19166-15-git-send-email-wad@chromium.org>
Date: Thu, 12 Apr 2012 15:11:50 -0700
Message-ID: <CAGXu5jLLoOqSS_zYehi1TbDXDPqitnAN1S401zgReRgEfUaTYw@mail.gmail.com>
Subject: Re: [PATCH v18 15/15] Documentation: prctl/seccomp_filter
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, hpa@zytor.com, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, jmorris@namei.org
Message-ID: <20120412221150.XOEII1Cy2IA9BtiANd4EN8DvB8gU_Ha6eeFZzyZn7lg@z>

On Thu, Apr 12, 2012 at 2:48 PM, Will Drewry <wad@chromium.org> wrote:
> Documents how system call filtering using Berkeley Packet
> Filter programs works and how it may be used.
> Includes an example for x86 and a semi-generic
> example using a macro-based code generator.
>
> Acked-by: Eric Paris <eparis@redhat.com>
> Signed-off-by: Will Drewry <wad@chromium.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
ChromeOS Security
