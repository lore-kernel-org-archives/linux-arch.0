Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62680
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161025AbWARV6T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jan 2006 16:58:19 -0500
Date: Wed, 18 Jan 2006 13:58:15 -0800 (PST)
Message-Id: <20060118.135815.86692020.davem@davemloft.net>
Subject: Re: new syscalls
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43CEB7A6.1030207@redhat.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
	<20060118133629.1cda96fd.akpm@osdl.org>
	<43CEB7A6.1030207@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: drepper@redhat.com
Cc: akpm@osdl.org, tony.luck@intel.com, linux-arch@vger.kernel.org, janak@us.ibm.com, dwmw2@infradead.org, dhowells@redhat.com, davidel@xmailserver.org, christoph@lameter.com
List-ID: <linux-arch.vger.kernel.org>

From: Ulrich Drepper <drepper@redhat.com>
Date: Wed, 18 Jan 2006 13:48:22 -0800

> glibc

This puts an unnecessary burdon upon kernel platform maintainers.
They should not be required to go through the work and time of getting
together a sane enough build environment to build the current glibc
sources.

What we want is a self contained directory of small tests that
exercise the syscalls directly and do not have any dependency
on any large source base or installed libraries.

If I remember correctly, the folks who did EPOLL did exactly this
and the syscall additions were trivial to test as a result.
