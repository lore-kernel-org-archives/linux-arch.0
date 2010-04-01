From: David Howells <dhowells@redhat.com>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Thu, 01 Apr 2010 12:06:10 +0100
Message-ID: <31829.1270119970@redhat.com>
References: <1270104536.7101.114.camel@pasglop> <20100325194100.GA2364@debian> <20100331134048.da4e35a7.akpm@linux-foundation.org> <4BB3B4DB.7040904@kernel.org> <20100331210145.GB32165@parisc-linux.org> <4BB3B8FC.1020608@zytor.com> <20100331211754.GC32165@parisc-linux.org> <alpine.DEB.2.00.1003311640410.30456@router.home> <20100331215411.GB17715@flint.arm.linux.org.uk> <4BB3C540.9000405@zytor.com> <1270075071.7101.79.camel@pasglop> <20100331154955.54176e5e.akpm@linux-foundation.org> <1270084631.7101.81.camel@pasglop> <20100331182654.d36c87ff.akpm@linux-foundation.org> <4BB43CAC.3080102@zytor.com> <20100331233330.1a7357e4.akpm@linux-foundation.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64426 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758585Ab0DAQkQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Apr 2010 12:40:16 -0400
In-Reply-To: <1270104536.7101.114.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Lameter <cl@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>, Yinghai Lu <yinghai@kernel.org>, Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi, linux-arch@vger.kernel.org


Can we provide a kmem_cache_create_early()?  One that takes no locks and gets
cleaned up with the other __init stuff?

David
