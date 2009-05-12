From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] x86: fix ktermios-termio conversion
Date: Tue, 12 May 2009 13:42:18 +0200
Message-ID: <200905121342.19093.arnd@arndb.de>
References: <20090511222702.352192505@arndb.de> <200905121104.31275.arnd@arndb.de> <20090512091010.GD18004@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:58945 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbZELLne (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 May 2009 07:43:34 -0400
In-Reply-To: <20090512091010.GD18004@elte.hu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-arch@vger.kernel.org

On Tuesday 12 May 2009, Ingo Molnar wrote:
> hm, on x86 you could use get_user_try / get_user_ex() / 
> get_user_catch() approach to linearize the dependencies and reduce 
> register pressure.

Yes, but that would not help my intention of making the file more
generic. The x86 code was copied into a number of architectures, and
at least arm, m32r, parisc, sh and xtensa have big-endian configurations
where the implementation is wrong.

I only realized that while writing this email though and I guess I
need to fix those as well now ;-) 

	Arnd <><
