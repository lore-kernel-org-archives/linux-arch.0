Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050323174810.17df4440.sfr@canb.auug.org.au> 
References: <20050323174810.17df4440.sfr@canb.auug.org.au>  <20050323150123.1a78e9c4.sfr@canb.auug.org.au> 
Subject: Re: [PATCH] consolidate shmat usage 
Date: Wed, 23 Mar 2005 10:54:28 +0000
Message-ID: <27271.1111575268@redhat.com>
Sender: dhowells@redhat.com
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> This patch creates sys_shmat and sys_smhatcall and uses them wherever
> possible - this tidies up sys_ipc a bit in most cases.  I have not touched
> um arch.
> 
> I am eventually aiming at consolidating (as much as possible of) sys_ipc
> and doing compat_sys_ipc.
> 
> I suspetc the conditional compilation of sys_shmat{,call} is a bit much
> and have no problem with removing the conditionals.

Looks okay to me; but the #ifdef haters are going to hate your guts and insist
that the sys_shmat and sys_shmatcall functions you added go in their own files
and get conditionally included by the Makefile.

David
