From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: LTP for no MMU systems
Date: Tue, 6 May 2008 11:37:58 -0400
Message-ID: <8bd0f97a0805060837x530bc130vd5b15392d5549c3d@mail.gmail.com>
References: <48206ECF.9090005@seznam.cz>
	 <8bd0f97a0805060749j28cb6fe6wfbdf0d3948d2f417@mail.gmail.com>
	 <48207888.3070107@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:16676 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760697AbYEFPiD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 11:38:03 -0400
Received: by el-out-1112.google.com with SMTP id n30so881844elf.21
        for <linux-arch@vger.kernel.org>; Tue, 06 May 2008 08:37:59 -0700 (PDT)
In-Reply-To: <48207888.3070107@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Tue, May 6, 2008 at 11:26 AM, Michal Simek <monstr@seznam.cz> wrote:
>  where is your repo with ltp and tests results?

we just pull down the LTP releases and any fixes/changes that need to
be made, i commit back upstream.  as for results, i'll have to ask our
testers.
-mike
