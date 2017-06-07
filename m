Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36359 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdFGVyS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 17:54:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id y7so2811180pfd.3
        for <linux-arch@vger.kernel.org>; Wed, 07 Jun 2017 14:54:18 -0700 (PDT)
Date: Wed, 07 Jun 2017 14:54:16 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: RISC-V Linux Port v2
In-Reply-To: <20170607092342.GB30263@arm.com>
Message-ID: <mhng-9bc0a031-a834-42cc-aec0-cfb2efc8fe0c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org
Message-ID: <20170607215416.UKpvLcAHVWwbB06tDlzAOwsZTsFSVadkVwCOQyFZ0zs@z>

On Wed, 07 Jun 2017 02:23:42 PDT (-0700), will.deacon@arm.com wrote:
> Hi Palmer,
>
> On Tue, Jun 06, 2017 at 03:59:50PM -0700, Palmer Dabbelt wrote:
>> Thanks to everyone who has participated in the review process so far.  We've
>> made a lot of changes since the v1 and while this isn't ready to go yet, I
>> finally managed to get through everything in my inbox so I thought it would be
>> a good time to submit a v2 so everyone is on the same page.
>
> [...]
>
>> [PATCH 13/17] RISC-V: Add include subdirectory
>
> This guy is too big, and got silently dropped by the mailing list. Any
> chance you could split it up please, so that it can be reviewed?

Sorry about that.  It's online

  https://github.com/riscv/riscv-linux/commit/daaea1609cb5e8c93745c1ce112a06e90f5b663c

I'll be sure to split it up next time.  I can submit a v3 if you want?
