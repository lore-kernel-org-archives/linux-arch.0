Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel12.hp.com ([156.153.255.237]:9879 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263464AbUDZUWb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Apr 2004 16:22:31 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16525.28547.291544.877628@napali.hpl.hp.com>
Date: Mon, 26 Apr 2004 13:22:27 -0700
Subject: Re: Fw: [rft] testing BSD accounting format on different archs
In-Reply-To: <20040425214107.3067d355.davem@redhat.com>
References: <20040424131706.3d1f2c53.akpm@osdl.org>
	<20040425214107.3067d355.davem@redhat.com>
Reply-To: davidm@hpl.hp.com
To: tim@physik3.uni-rostock.de
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Sun, 25 Apr 2004 21:41:07 -0700, "David S. Miller" <davem@redhat.com> said:

  DaveM> "uname" on my system didn't understand all of the options you
  DaveM> seem to be giving it

Same here.  I used "uname -a".

	--david

Linux wailua.hpl.hp.com 2.6.5 #6 SMP Thu Apr 8 18:01:22 PDT 2004 ia64 GNU/Linux

             v0  v1  v2
ac_flag       0   0   0
ac_version        1   1
ac_uid16      2   2   2
ac_gid16      4   4   4
ac_tty        6   6   6
ac_btime      8   8   8
ac_utime     12  12  12
ac_stime     14  14  14
ac_etime     16  16  16
ac_mem       18  18  18
ac_io        20  20  20
ac_rw        22  22  22
ac_minflt    24  24  24
ac_majflt    26  26  26
ac_swaps     28  28  28
ac_ahz           30  36
ac_exitcode  32  32  32
ac_comm      36  36  38
ac_etime_hi      53  55
ac_etime_lo      54  56
ac_uid           56  60
ac_gid           60  64
sizeof(struct acct)
             64  64  68

    01 00 04 03  06 05 08 07  0c 0b 0a 09  0e 0d 10 0f
    12 11 14 13  16 15 18 17  1a 19 1c 1b  1e 1d 00 00
    24 23 22 21  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30
    31 32 33 34  35 f0 f1 f2  f3 f4 f5 f6  f7 f8 f9 00

    01 02 04 03  06 05 08 07  0c 0b 0a 09  0e 0d 10 0f
    12 11 14 13  16 15 18 17  1a 19 1c 1b  1e 1d 20 1f
    24 23 22 21  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30
    31 32 33 34  35 36 38 37  3c 3b 3a 39  40 3f 3e 3d

    01 02 04 03  06 05 08 07  0c 0b 0a 09  0e 0d 10 0f
    12 11 14 13  16 15 18 17  1a 19 1c 1b  1e 1d 00 00
    24 23 22 21  20 1f 25 26  27 28 29 2a  2b 2c 2d 2e
    2f 30 31 32  33 34 35 36  38 37 00 00  3c 3b 3a 39
