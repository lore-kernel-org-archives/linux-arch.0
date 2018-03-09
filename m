Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:38921 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751106AbeCINFa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Mar 2018 08:05:30 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.85)
          for linux-arch@vger.kernel.org with esmtps (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1euHiD-003K6W-AI>; Fri, 09 Mar 2018 14:05:29 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.85)
          for linux-arch@vger.kernel.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1euHiD-002iLl-3r>; Fri, 09 Mar 2018 14:05:29 +0100
Subject: Re: Debian Ports architecture status (Re: Re: Removing architectures
 without upstream gcc support)
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <fbfb535b-65ac-4b16-469a-9ccc9cb5e714@physik.fu-berlin.de>
Message-ID: <9047d1e0-1281-4124-82b1-0b5b5d02860b@physik.fu-berlin.de>
Date: Fri, 9 Mar 2018 14:05:28 +0100
MIME-Version: 1.0
In-Reply-To: <fbfb535b-65ac-4b16-469a-9ccc9cb5e714@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>

Hi!

On 03/09/2018 01:55 PM, John Paul Adrian Glaubitz wrote:
> Some notes per architecture:

I forgot to mention powerpc and ppc64:

Both the 32-bit and 64-bit big-endian PowerPC ports in Debian are
in very good shape. They build over 12200 out of 12900 packages with
almost no issues. Both powerpc and ppc64 could be release architectures
but it was unfortunately decided that Debian would support the little-
endian PowerPC port (ppc64el) for the time being.

The only known issues are lack of support in Golang as IBM/Golang
decided to kill off support for anything older than POWER8 in the
ppc64 port and the lack of a Hotspot port for powerpc in OpenJDK
(there is support for powerpc in the Zero variant of OpenJDK
though).

Both powerpc and ppc64 are supported as QEMU targets, both as qemu-user
and qemu-system. Both ports are maintained by the Debian Ports team.

Thanks,
Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
