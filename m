Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:52132 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdFITxw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2017 15:53:52 -0400
Received: from localhost.localdomain ([127.0.0.1]:54194 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993954AbdFITxs3gbdn (ORCPT <rfc822;linux-arch@vger.kernel.org>
        + 3 others); Fri, 9 Jun 2017 21:53:48 +0200
Date: Fri, 9 Jun 2017 21:53:22 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 7/7] MIPS: Use generic libgcc intrinsics
Message-ID: <20170609195322.GA18307@linux-mips.org>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <20170606191023.24581-1-palmer@dabbelt.com>
 <20170606191023.24581-8-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606191023.24581-8-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: monstr@monstr.eu, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <20170609195322.cR3o4MBtqGRb5uyUDxAqieJUTT7mcsXrV814bgV96LM@z>

On Tue, Jun 06, 2017 at 12:10:23PM -0700, Palmer Dabbelt wrote:

> These routines in arch/mips/lib/ are functionally identical to those
> recently added to lib/ so remove them and select the generic ones.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Thanks, nice cleanup!

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
