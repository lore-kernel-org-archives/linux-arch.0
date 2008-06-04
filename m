From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCHv4 6/6] byteorder: add copy_{endian} helpers
Date: Wed, 04 Jun 2008 11:38:01 -0700
Message-ID: <1212604681.6340.28.camel@brick>
References: <1212428244.11008.40.camel@brick>
	 <Pine.LNX.4.64.0806022038400.6262@anakin>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.183]:1272 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbYFDSiE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jun 2008 14:38:04 -0400
Received: by el-out-1112.google.com with SMTP id v27so112705ele.23
        for <linux-arch@vger.kernel.org>; Wed, 04 Jun 2008 11:38:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0806022038400.6262@anakin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, "tony.luck" <tony.luck@intel.com>

On Mon, 2008-06-02 at 21:15 +0200, Geert Uytterhoeven wrote:
> On Mon, 2 Jun 2008, Harvey Harrison wrote:
> > Add helpers for the idiom:
> > *(__le16 *)ptr = cpu_to_le16(val);
> > 
> > Can now be written as:
> > copy_le16(ptr, val);
> 
> Copy a little endian 16-bit value?
> 
> It doesn't just copy. It does a byteswap during the copy.
> 

True, I had originally called this put_le16.  akpm suggested copy_le16.
What do people think of copy_as_le16?

Harvey
