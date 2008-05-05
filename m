From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 10/56] microblaze_v2: Generic dts file for platforms
Date: Mon, 5 May 2008 08:31:52 -0600
Message-ID: <fa686aa40805050731gc29e88hdc4917041a63e12f@mail.gmail.com>
References: <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>
	 <2391e49379fb6639f57d9d6e5811f3d49a4c6fda.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:8555 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590AbYEEObx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 10:31:53 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1211614wra.1
        for <linux-arch@vger.kernel.org>; Mon, 05 May 2008 07:31:53 -0700 (PDT)
In-Reply-To: <2391e49379fb6639f57d9d6e5811f3d49a4c6fda.1209897266.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>

On Sun, May 4, 2008 at 5:40 AM,  <monstr@seznam.cz> wrote:
> From: Michal Simek <monstr@monstr.eu>
>
>
>  Signed-off-by: Michal Simek <monstr@monstr.eu>
>  ---
>   arch/microblaze/platform/generic/system.dts |  137 +++++++++++++++++++++++++++

What is the purpose of the generic dts?  Will this work with custom
microblaze designs?  The header block should contain a comment about
what this file is for.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
