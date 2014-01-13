Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.sr71.net ([198.145.64.142]:43905 "EHLO blackbird.sr71.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbaAMUam (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Jan 2014 15:30:42 -0500
Message-ID: <52D44C98.70906@sr71.net>
Date: Mon, 13 Jan 2014 12:29:12 -0800
From: Dave Hansen <dave@sr71.net>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] kconfig: consolidate arch-specific seccomp options
References: <20140102202014.CA206E9B@viggo.jf.intel.com> <52D44141.4020304@infradead.org>
In-Reply-To: <52D44141.4020304@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20140113202912.yUDYEyPtcV9VGY5s-lDPr58V33V6iwWiQfWAkcb3T80@z>

On 01/13/2014 11:40 AM, Randy Dunlap wrote:
>> > +config SECCOMP
>> > +	bool
>> > +	default y
> Prefer
> 	def_bool y

I've actually got that already in my updated set that I'll send out when
the merge window opens.

