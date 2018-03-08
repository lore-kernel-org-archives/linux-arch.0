Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36687 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbeCHROx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Mar 2018 12:14:53 -0500
Received: by mail-pf0-f175.google.com with SMTP id 68so148126pfx.3
        for <linux-arch@vger.kernel.org>; Thu, 08 Mar 2018 09:14:53 -0800 (PST)
Date: Thu, 08 Mar 2018 09:14:52 -0800 (PST)
Subject: Re: RFC: remove the "tile" architecture from glibc
In-Reply-To: <CAK8P3a2VuYxzy6RmL_w_5f2qHepVRhfVR5P4x9nCUYav1s5n7g@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-160eeec9-bd53-4c63-901a-630c66a78534@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: helmut@subdivi.de, Arnd Bergmann <arnd@arndb.de>, glaubitz@physik.fu-berlin.de, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, metcalf@alum.mit.edu, hgb@ifi.uio.no, linux-kernel@vger.kernel.org
Message-ID: <20180308171452.ajm1t3axNg1SsCJYa4yFi_07oD9o1qBSKdxR2XELNpA@z>

On Thu, 08 Mar 2018 07:55:33 PST (-0800), Arnd Bergmann wrote:
> - riscv32 is not yet supported by Linux or glibc, but that seems
>   very likely to come in the future, maybe one or two years from
>   now.

I'm hoping it'll be a lot less than a year away :).
