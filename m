From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 15/37] wireless: use get/put_endian helpers
Date: Thu, 29 May 2008 14:47:05 -0700
Message-ID: <1212097625.28403.144.camel@brick>
References: <1212092308.28403.117.camel@brick>
	 (sfid-20080529_221900_617991_210BEC75)  <1212096681.10109.0.camel@johannes.berg>
	 <1212096945.28403.141.camel@brick>
	 (sfid-20080529_233551_020981_7B2BB967)  <1212097411.10109.3.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:8425 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611AbYE2VrK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 17:47:10 -0400
Received: by yx-out-2324.google.com with SMTP id 31so409145yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 14:47:09 -0700 (PDT)
In-Reply-To: <1212097411.10109.3.camel@johannes.berg>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, John Linville <linville@tuxdriver.com>

On Thu, 2008-05-29 at 23:43 +0200, Johannes Berg wrote:
> On Thu, 2008-05-29 at 14:35 -0700, Harvey Harrison wrote:
> > On Thu, 2008-05-29 at 23:31 +0200, Johannes Berg wrote:
> > > > -	ADM8211_CSR_WRITE(BSSID0, le32_to_cpu(*(__le32 *)bssid));
> > > > +	ADM8211_CSR_WRITE(BSSID0, get_le32((__le32 *)bssid));
> > > 
> > > Maybe I'm stupid, but isn't this the same as le32_to_cpup? Or does
> > > get_le32 handle unaligned values?
> 
> > You're not stupid, but there is a new put_le32 as well that takes
> > aligned values similar to the put_unaligned_le32, so get_le32 was
> > added to have an analog to get_unaligned_le32 as well.
> 
> So this is just to make the API "complete"? Are we removing le32_to_cpup
> and the associated API then?
> 
> johannes

At the end of the series, there are no more users of the
{endian}_to_cpup family left, so they could be removed, but I
did not include that in this set.

It seems as if infiniband and some areas of net/ were the only places
that knew of the p version as there were lots of le16_to_cpu(*(__le16 *)ptr)
around the tree.

Harvey
