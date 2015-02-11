From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3.18 04/57] vm: add VM_FAULT_SIGSEGV handling support
Date: Tue, 10 Feb 2015 19:49:27 -0800
Message-ID: <CA+55aFxWCxq59cfG9Uvm3AAx9MngWENjz1oRayPQMb8+8pVnMA@mail.gmail.com>
References: <20150203231211.486950145@linuxfoundation.org>
	<20150203231212.223123220@linuxfoundation.org>
	<CALYGNiPVvgxMFyDTSFv4mUhkq-5Q+Gp2UEY5W9G0gEc8YajipQ@mail.gmail.com>
	<20150211034307.GA2932@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:50576 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbbBKDt2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Feb 2015 22:49:28 -0500
In-Reply-To: <20150211034307.GA2932@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stable <stable@vger.kernel.org>, Jan Engelhardt <jengelh@inai.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>

On Tue, Feb 10, 2015 at 7:43 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Ah, nice, I missed that one.

Ugh, to be fair, I missed it too.

The alternative to backporting 7fb08eca4527 is to make the backport of
commit 33692f27597f use "bad_area()" instead of
"bad_area_nosemaphore()".

                    Linus
