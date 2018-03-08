Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38813 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeCHXgN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Mar 2018 18:36:13 -0500
MIME-Version: 1.0
In-Reply-To: <mhng-160eeec9-bd53-4c63-901a-630c66a78534@palmer-si-x1c4>
References: <CAK8P3a2VuYxzy6RmL_w_5f2qHepVRhfVR5P4x9nCUYav1s5n7g@mail.gmail.com>
 <mhng-160eeec9-bd53-4c63-901a-630c66a78534@palmer-si-x1c4>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Mar 2018 00:36:11 +0100
Message-ID: <CAK8P3a0nBfwyUS7DuCp46O6NnBQOD8Hb-4B78TeqXQhoRanMPA@mail.gmail.com>
Subject: Re: RFC: remove the "tile" architecture from glibc
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Helmut Grohne <helmut@subdivi.de>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, GNU C Library <libc-alpha@sourceware.org>, linux-arch <linux-arch@vger.kernel.org>, metcalf@alum.mit.edu, Henrik Grindal Bakken <hgb@ifi.uio.no>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180308233611.Xa1pkK8K55WWxIWPXAjajmqCriYvdX2v94ANrbPSDpE@z>

On Thu, Mar 8, 2018 at 6:14 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Thu, 08 Mar 2018 07:55:33 PST (-0800), Arnd Bergmann wrote:
>>
>> - riscv32 is not yet supported by Linux or glibc, but that seems
>>   very likely to come in the future, maybe one or two years from
>>   now.
>
>
> I'm hoping it'll be a lot less than a year away :).

Ah, very good. For some reason I was under the impression that all
the early hardware with Linux support was 64-bit only, and the
32-bit Linux port therefore a low priority, but even better if that's
coming soon.

     Arnd
