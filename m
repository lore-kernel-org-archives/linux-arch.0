Return-Path: <anton@samba.org>
Received: from dp.samba.org ([66.70.73.150]:63399 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262453AbUCSBhm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Mar 2004 20:37:42 -0500
Date: Fri, 19 Mar 2004 12:37:20 +1100
From: Anton Blanchard <anton@samba.org>
Subject: Re: pci_map_single return value
Message-ID: <20040319013720.GQ28212@krispykreme>
References: <20031212155752.GD17683@krispykreme> <20031212175104.07dc8444.ak@suse.de> <20031212192131.GF17683@krispykreme> <20031213220444.4c526afa.davem@redhat.com> <20040102120121.GT28023@krispykreme> <20040102133454.22daa451.ak@suse.de> <20040319001448.GP28212@krispykreme> <20040318165550.3f5068b4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318165550.3f5068b4.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, davem@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

 
> Spose so.  Does this mean driver patches are on the way?

Thats the plan. The IPR, ibmvscsi and emulex drivers already have hacks
in them to do this in an arch specific way. None of those drivers are
merged yet, although the IPR and ibmvscsi is close.

Anton
