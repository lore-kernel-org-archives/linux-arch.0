Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10850 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758734AbaGONQ3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jul 2014 09:16:29 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1405413956-2772-1-git-send-email-lftan@altera.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
Subject: Re: [PATCH v2 00/29] nios2 Linux kernel port
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4212.1405430178.1@warthog.procyon.org.uk>
Date: Tue, 15 Jul 2014 14:16:18 +0100
Message-ID: <4213.1405430178@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140715131618.6awPdokrNI6OCNDmYXwAQUnmnEjlzBHPsj-wgHPCQDw@z>

Ley Foon Tan <lftan@altera.com> wrote:

> Nios2 GCC port is in mainline and will be in the FSF 4.9 release.

I managed to build a nios2-linux-gnu cross compiler from gcc-4.9.0 that I can
add to the Fedora cross-compiler set.  I can't build libgcc without kernel
headers, though:-/

David
