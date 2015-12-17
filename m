From: Dan Williams <dan.j.williams@gmail.com>
Subject: Re: [PATCH 01/13] Make the x86 bitops like test_bit() return bool
Date: Thu, 17 Dec 2015 12:38:17 -0800
Message-ID: <CAA9_cmcW_82+j6kBXU4-70hqDL=m45WD_ukD52eGNiEyBWX_+A@mail.gmail.com>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
	<20150429192140.24909.56052.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36299 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932449AbbLQUiT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Dec 2015 15:38:19 -0500
In-Reply-To: <20150429192140.24909.56052.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Apr 29, 2015 at 12:21 PM, David Howells <dhowells@redhat.com> wrote:
> Make the x86 bitop functions like test_bit() return bool rather than an
> integer.  This permits gcc-5 to make better choices and can reduce the code
> size overall and allows some warnings to be evaded.

This also would have prevented this regression in -next:

https://lists.01.org/pipermail/linux-nvdimm/2015-December/003557.html
