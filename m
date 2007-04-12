Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:4993 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992600AbXDLQFu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Apr 2007 12:05:50 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: + expose-range-checking-functions-from-arch-specific.patchadded to -mm tree
Date: Thu, 12 Apr 2007 09:05:43 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A0157430D@scsmsx411.amr.corp.intel.com>
In-Reply-To: <1176334113.14322.130.camel@localhost.localdomain>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

> Actually, I think it's brilliantly documented.  Defining base as the
> first valid value and limit as the first invalid value makes it pretty
> clear, IMHO.

"first invalid value" is hard to express if the range you
want to check includes the largest value for the type
you are using.  Either "limit" needs to be the largest
allowable value, or you should stick to "base,len".

-Tony
