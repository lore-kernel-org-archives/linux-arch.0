From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/22] pci-dma-compat: Add pci_zalloc_consistent helper
Date: Wed, 25 Jun 2014 15:31:09 -0700 (PDT)
Message-ID: <20140625.153109.1658452238116055408.davem@davemloft.net>
References: <2248b3ffe86cd8995a809bf7e2871f38039979c1.1403530604.git.joe@perches.com>
	<20140625122755.152685fadbc9cffe7a298dc6@linux-foundation.org>
	<1403733111.24788.8.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:38742 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbaFYWbM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jun 2014 18:31:12 -0400
In-Reply-To: <1403733111.24788.8.camel@joe-AO725>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: joe@perches.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Wed, 25 Jun 2014 14:51:51 -0700

> On Wed, 2014-06-25 at 12:27 -0700, Andrew Morton wrote:
>> On Mon, 23 Jun 2014 06:41:29 -0700 Joe Perches <joe@perches.com> wrote:
>> 
>> > Add this helper for consistency with pci_zalloc_coherent
>> > and the ability to remove unnecessary memset(,0,) uses.
>> 
>> While we're being anal..  I'm not a big fan of the patch titles.  Worst
>> is "amd: Use pci_zalloc_consistent".  "amd" is quite a poor identifier
>> - it's only when you get in and look at the diff that you realise it's
>> an ethernet driver.
> 
> Yeah, those "amd:" prefixes should really have been "pcnet32:"
> 
>> People sometimes address this by using
>> 
>> 	"drivers: net: ethernet: amd: use pci_zalloc_consistent"
>> 
>> which strikes me as utterly perverse.  We already have a nice way of
>> representing the hierarchy and that's using '/'.
> 
> I used to do that until several people complained.
> Now I don't.  btw:  Documentation/SubmittingPatches says:
> 
> 15) The canonical patch format
> 
> The canonical patch subject line is:
> 
>     Subject: [PATCH 001/123] subsystem: summary phrase

+1

We've been representing subsystems using colon prefixes for ages, and
I can't seen the value of starting to use something inconsistent with
a decade of precedence.
