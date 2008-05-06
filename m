From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: LTP for no MMU systems
Date: Tue, 6 May 2008 10:49:04 -0400
Message-ID: <8bd0f97a0805060749j28cb6fe6wfbdf0d3948d2f417@mail.gmail.com>
References: <48206ECF.9090005@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:3290 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454AbYEFOto (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 10:49:44 -0400
Received: by yw-out-2324.google.com with SMTP id 9so738699ywe.1
        for <linux-arch@vger.kernel.org>; Tue, 06 May 2008 07:49:28 -0700 (PDT)
In-Reply-To: <48206ECF.9090005@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Tue, May 6, 2008 at 10:44 AM, Michal Simek <monstr@seznam.cz> wrote:
>  I tested Microblaze MMU kernel for finding where could be problem. I have no
>  problem with compilation. Microblaze MMU test result is on
>  http://www.monstr.eu/wiki/doku.php?id=kernel:testing.
>
>  I would like to test no MMU kernel too. Does anyone use it for no MMU kernel?
>  (Blackfin, m68k and others)

yes, we run many of the tests under testcases/kernel/ on Blackfin
-mike
