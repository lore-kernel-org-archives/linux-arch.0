From: Tzachi Perelstein <tzachi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/7][RFC] Move Marvell MBUS window handling into drivers
Date: Mon, 10 Mar 2008 10:31:25 +0200
Message-ID: <47D4F1DD.3090601@marvell.com>
References: <20080307101913.GA11918@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080307101913.GA11918-mfnYTeDhw6uOVk/H6u/4e9i2O/JbrIOy@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Dale Farnsworth <dale-1viX+2+OPRFcxvNqPlePQg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>

Lennert Buytenhek wrote:
> 
> This patch set is an initial attempt at moving programming of the
> MBUS register windows for the set of MBUS peripherals that we currently
> have in-tree drivers for from platform code into drivers.
> 
> With these patches, info about DRAM target/attribute IDs is prepared
> by the platform code as usual, but then passed into platform drivers
> via platform device data, instead of programming that data into the
> peripherals directly.
> 
> This avoids duplicating the window programming code across each
> platform that wants to use these peripherals, and avoids exposing
> internal peripheral register set details outside of their drivers.
> 
> Comments appreciated.
> 

At the beginning I had some hard time to agree with this concept 
of leaving the mbus windows to be handled at drivers level instead 
of the arch level, mainly because the mbus bits looks somehow 
different on every orion/discovery chips. My feeling was that this 
approach will either fail on some chips or will be very cumbersome.

Well, I was wrong. Reviewing the patches against orion/discovery 
specs shows that this patchset indeed handles all these bits 
differences correctly, and in a very simple and elegant manner. 
So I like it a lot ;) 

For the whole set --
Reviewed-by: Tzachi Perelstein <tzachi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
