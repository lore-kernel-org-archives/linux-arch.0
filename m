Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.136]:52987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeJEGER (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Oct 2018 02:04:17 -0400
Subject: Re: [PATCH 5/5] arch/xtensa, termios: use <asm-generic/termbits.h>
References: <20181004222953.2229-1-hpa@zytor.com>
 <20181004222953.2229-6-hpa@zytor.com>
 <CAMo8BfJRvmNu=oHb4MaB_M7mdR5dMZRgfHb-Me8En3OoUe5m8g@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e2439721-ff84-6943-2295-b7fb2d082ef9@zytor.com>
Date: Thu, 4 Oct 2018 16:08:19 -0700
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJRvmNu=oHb4MaB_M7mdR5dMZRgfHb-Me8En3OoUe5m8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-serial@vger.kernel.org, Chris Zankel <chris@zankel.net>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, pombredanne@nexb.com, kstewart@linuxfoundation.org, linux-xtensa@linux-xtensa.org, Jiri Slaby <jslaby@suse.com>
Message-ID: <20181004230819.KjsBZxJKmW8mlybrKsfl84jxmOSOLD4MMkbmZWa5siE@z>

On 10/04/18 15:35, Max Filippov wrote:
> 
> Looks good. But why not removing the header entirely and adding
> generic-y += termbits.h
> to arch/xtensa/include/uapi/asm/Kbuild?
> 

Good idea.  Should do that for others that also have the same #include.

	-hpa
