Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:47050 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262585AbUF3UyY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Jun 2004 16:54:24 -0400
Date: Wed, 30 Jun 2004 13:53:42 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: compat_sys_adjtimex
Message-Id: <20040630135342.01eaea83.davem@redhat.com>
In-Reply-To: <40E30E8F.3000601@intel.com>
References: <40E30E8F.3000601@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 30 Jun 2004 12:03:43 -0700
Arun Sharma <arun.sharma@intel.com> wrote:

> This system call seems to be duplicated in many architectures. Here's
> a patch which moves it to kernel/compat.c
> 
> We didn't touch ppc64, because it seems to be different. We've tested
> this on ia64 with LTP.

PPC64 just wants some kind of callback invoked right after the
do_adjtimex() call, it should be possible to provide a "do-nothing"
macro in linux/compat.h that ppc can override in asm/compat.h
