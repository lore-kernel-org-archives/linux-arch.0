Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56403 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965122AbXDKTSY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Apr 2007 15:18:24 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20070411113101.6a444667.akpm@linux-foundation.org> 
References: <20070411113101.6a444667.akpm@linux-foundation.org>  <1176297479.14322.69.camel@localhost.localdomain> <200704062127.l36LRMA7019394@shell0.pdx.osdl.net> <6632.1176200270@redhat.com> <1176257950.26372.50.camel@localhost.localdomain> <20070410194834.b688ce55.akpm@linux-foundation.org> <400.1176310986@redhat.com> 
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch added to -mm tree 
Date: Wed, 11 Apr 2007 20:17:56 +0100
Message-ID: <15812.1176319076@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton <akpm@linux-foundation.org> wrote:

> If we (crazily) agree that we should/coould/might grow a suite of
> range-handling functions then we should stick to the range_foo() namespace
> for that.

range_check_limit() then.
