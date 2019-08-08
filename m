Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:35818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfHHQ1H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 12:27:07 -0400
Date: Thu, 8 Aug 2019 17:27:02 +0100
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Message-ID: <20190808162702.GJ10425@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Will Deacon <will.deacon@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <20190808162702.RQNvVBE_CIhgSWCOP0Q8zsz7X51AwS-MQtsJ5ZtLCFE@z>

On Wed, Aug 07, 2019 at 01:38:16PM -0700, Dave Hansen wrote:

[Random comments below on a couple of points]

> On 8/7/19 8:53 AM, Catalin Marinas wrote:
> > +- mmap() done by the process itself (or its parent), where either:
> > +
> > +  - flags have the **MAP_ANONYMOUS** bit set
> > +  - the file descriptor refers to a regular file (including those returned
> > +    by memfd_create()) or **/dev/zero**
> 
> What's a "regular file"? ;)

A file, as distinct from device nodes, sockets, symlinks etc.

I think this is fairly standard UNIX terminology, even though it sounds
vague:
