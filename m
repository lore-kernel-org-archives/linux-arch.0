Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050323150123.1a78e9c4.sfr@canb.auug.org.au> 
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au> 
Subject: Re: [PATCH] consolidate asm/ipc.h 
Date: Wed, 23 Mar 2005 10:49:48 +0000
Message-ID: <27167.1111574988@redhat.com>
Sender: dhowells@redhat.com
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> All the asm*/ipc.h files are basically the same (for things that are used)
> so I have consolidated them all into asm-generic/ipc.h

The FRV bit looks okay to me.

Acked-By: David Howells <dhowells@redhat.com>
