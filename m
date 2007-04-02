Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:1242 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965999AbXDBWmL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Apr 2007 18:42:11 -0400
Message-ID: <461186A7.2020803@google.com>
Date: Mon, 02 Apr 2007 15:41:43 -0700
From: Martin Bligh <mbligh@google.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] x86_64: Switch to SPARSE_VIRTUAL
References: <20070401071024.23757.4113.sendpatchset@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0704021422040.2272@schroedinger.engr.sgi.com> <1175550968.22373.122.camel@localhost.localdomain> <200704030031.24898.ak@suse.de> <Pine.LNX.4.64.0704021534100.25602@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0704021534100.25602@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Dave Hansen <hansendc@us.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-ID: <linux-arch.vger.kernel.org>

Christoph Lameter wrote:
> On Tue, 3 Apr 2007, Andi Kleen wrote:
> 
>> If it works I would be inclined to replaced old sparsemem with Christoph's
>> new one on x86-64. Perhaps that could cut down the bewildering sparsemem
>> ifdef jungle that is there currently.
>>
>> But I presume it won't work on 32bit because of the limited address space?
> 
> Not in general but it will work in non PAE mode. 4GB need 2^(32-21+4) = 
> 16MB pages. This would require the mapping on 4 4MB pages.

IIRC NUMA isn't supported (or useful anyway) without PAE.

> For 64GB you'd need 256M which would be a quarter of low mem. Probably 
> takes up too much of low mem.

Yup.


M.
