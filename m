Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 05:11:41 -0500
From: Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213101141.GI31785@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213090429.GC27857@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213090429.GC27857@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Dec 13, 2005 at 09:04:29AM +0000, Christoph Hellwig wrote:
> > 
> > Remove -Wdeclaration-after-statement
> > 
> > Now that gcc 2.95 is not supported anymore it's ok to use C99
> > style mixed declarations everywhere.
> 
> Nack.  This code style is pure obsfucation and we should disallow it forever.

Why?  It greatly increases readability when variable declarations can be
moved close to their actual uses.  glibc changed a lot of its codebase
this way and from my experience it really helps.

	Jakub
