Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:8641 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265259AbUETU6N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 May 2004 16:58:13 -0400
Date: Thu, 20 May 2004 13:58:02 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: sys_getdents64 needs compat wrapper ?
Message-Id: <20040520135802.0e6fcf98.davem@redhat.com>
In-Reply-To: <40ACF9B7.30900@intel.com>
References: <40ACF9B7.30900@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 20 May 2004 11:32:23 -0700
Arun Sharma <arun.sharma@intel.com> wrote:

> Running 32 bit ls on ia64 produces kernel mode unaligned faults with the attached backtrace on 2.6.6. I'm curious why this isn't a problem for other compat archs.

Other compat archs choose not to log unaligned kernel accesses
since they are common in some networking configurations and/or
combinations of drivers.

This one is a fixable case though, have a patch to suggest?
:-)
