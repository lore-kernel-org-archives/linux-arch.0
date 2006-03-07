Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from detroit.securenet-server.net ([209.51.153.26]:58340 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1751526AbWCGUBh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Mar 2006 15:01:37 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Tue, 7 Mar 2006 12:01:21 -0800
References: <200603071134.52962.ak@suse.de> <1141759408.2617.9.camel@serpentine.pathscale.com> <200603071257.24234.ak@suse.de>
In-Reply-To: <200603071257.24234.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071201.22397.jbarnes@virtuousgeek.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Bryan O'Sullivan <bos@serpentine.com>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday, March 7, 2006 3:57 am, Andi Kleen wrote:
> On Tuesday 07 March 2006 20:23, Bryan O'Sullivan wrote:
> > On Tue, 2006-03-07 at 18:30 +0000, David Howells wrote:
> > > True, I suppose. I should make it clear that these accessor
> > > functions imply memory barriers, if indeed they do,
> >
> > They don't, but according to Documentation/DocBook/deviceiobook.tmpl
> > they are performed by the compiler in the order specified.
>
> I don't think that's correct. Probably the documentation should
> be fixed.

On ia64 I'm pretty sure it's true, and it seems like it should be in the 
general case too.  The compiler shouldn't reorder uncached memory 
accesses with volatile semantics...

Jesse
