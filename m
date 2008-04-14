From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 2/2] kernel: Move arches to use common unaligned access
Date: Mon, 14 Apr 2008 11:32:09 +0100
Message-ID: <4392.1208169129@redhat.com>
References: <1207950449.22001.106.camel@brick>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1207950449.22001.106.camel@brick>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> -#ifndef _ASM_UNALIGNED_H
> -#define _ASM_UNALIGNED_H
> +#ifndef _ASM_FRV_UNALIGNED_H_
> +#define _ASM_FRV_UNALIGNED_H_

Please don't.  Why do you need to change these to make your patch work?

> -extern int handle_misalignment(unsigned long esr0, unsigned long ear0, unsigned long epcr0);

Don't lose this please, not unless you're going to erase the
handle_misalignment() function and remove the refs to it.

David
