Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:3672 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbYDVPei (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2008 11:34:38 -0400
Received: by ti-out-0910.google.com with SMTP id 28so684829tif.23
        for <linux-arch@vger.kernel.org>; Tue, 22 Apr 2008 08:34:04 -0700 (PDT)
Message-ID: <87a5b0800804220834q4d6daec1x4146d211115ab5c@mail.gmail.com>
Date: Tue, 22 Apr 2008 16:34:03 +0100
From: "Will Newton" <will.newton@gmail.com>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
In-Reply-To: <20080422152426.GG19802@phobos.i.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
	 <20080422081211.e85989ec.randy.dunlap@oracle.com>
	 <87a5b0800804220816y72a7f4f9gec2111df08a1a57f@mail.gmail.com>
	 <20080422152426.GG19802@phobos.i.cabal.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20080422153403.4YEj2PQN_ljtqKHq9ZWlN7mFjBTq7VXokC6ZFbJ8e8s@z>

On Tue, Apr 22, 2008 at 4:24 PM, Kyle McMartin <kyle@mcmartin.ca> wrote:
> On Tue, Apr 22, 2008 at 04:16:17PM +0100, Will Newton wrote:
>  > It can be done with Kconfig. Whether it should be or not depends on
>  > your point of view, hence RFC. Currently __ARCH_WANT macros is the way
>  > syscalls are enabled and disabled across architectures. If there's
>  > consensus that it should be done via Kconfig that could certainly be
>  > implmented, but that's a different patch.
>  >
>
>  It's currently done in unistd.h for hysterical raisins. All new
>  conditional syscalls have been done in Kconfig.

Do you have a syscall in mind that does this in the correct way?

BTW, don't blame the blackfin guys for this, I'm thinking about future
architectures that may be added rather than any existing ones. ;-)
