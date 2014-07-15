From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 00/29] nios2 Linux kernel port
Date: Tue, 15 Jul 2014 14:16:18 +0100
Message-ID: <4213.1405430178@warthog.procyon.org.uk>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1405413956-2772-1-git-send-email-lftan@altera.com>
Content-ID: <4212.1405430178.1@warthog.procyon.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

Ley Foon Tan <lftan@altera.com> wrote:

> Nios2 GCC port is in mainline and will be in the FSF 4.9 release.

I managed to build a nios2-linux-gnu cross compiler from gcc-4.9.0 that I can
add to the Fedora cross-compiler set.  I can't build libgcc without kernel
headers, though:-/

David
