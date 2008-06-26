Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:40264 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbYFZSPd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 14:15:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so143855rvb.1
        for <linux-arch@vger.kernel.org>; Thu, 26 Jun 2008 11:15:32 -0700 (PDT)
Message-ID: <2c0942db0806260935p51564a7et6517b39e9a6706dc@mail.gmail.com>
Date: Thu, 26 Jun 2008 09:35:22 -0700
From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: [PATCH 08/60] microblaze_v4: exception handling
In-Reply-To: <1214483429-32360-9-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	 <1214483429-32360-2-git-send-email-monstr@seznam.cz>
	 <1214483429-32360-3-git-send-email-monstr@seznam.cz>
	 <1214483429-32360-4-git-send-email-monstr@seznam.cz>
	 <1214483429-32360-5-git-send-email-monstr@seznam.cz>
	 <1214483429-32360-6-git-send-email-monstr@seznam.cz>
	 <1214483429-32360-7-git-send-email-monstr@seznam.cz>
	 <1214483429-32360-8-git-send-email-monstr@seznam.cz>
	 <1214483429-32360-9-git-send-email-monstr@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>
Message-ID: <20080626163522.SfOQFEbFaIwAv8f-wnFy3_460mf7S7isP0KHoRbmciU@z>

On Thu, Jun 26, 2008 at 5:29 AM,  <monstr@seznam.cz> wrote:
> +ex_sw:
> +       /* Get the destination register number into r5 */
> +       lbui    r5, r0, ex_reg_op;
> +       /* Form store_word jump table offset (sw_table + (8 * regnum)) */
> +       la      r6, r0, sw_table;
> +       add     r5, r5, r5;
> +       add     r5, r5, r5;
> +       add     r5, r5, r5;
> +       add     r5, r5, r6;
> +       bra     r5;

Possibly stupid question: This is part of the unaligned store word
exception handler, yes? Shouldn't the above add's be addk's to
preserve the state of the carry register pre/post store?
