Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de ([81.169.145.165]:62681 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S263101AbUDZIy0
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Apr 2004 04:54:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Fw: [rft] testing BSD accounting format on different archs
Date: Mon, 26 Apr 2004 10:53:50 +0200
References: <20040424131706.3d1f2c53.akpm@osdl.org>
In-Reply-To: <20040424131706.3d1f2c53.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_h4MjAamb8QCj9K7"
Message-Id: <200404261053.53723.arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Tim Schmielau <tim@physik3.uni-rostock.de>
List-ID: <linux-arch.vger.kernel.org>


--Boundary-00=_h4MjAamb8QCj9K7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

here is the output for s390

--Boundary-00=_h4MjAamb8QCj9K7
Content-Type: text/plain;
  charset="iso-8859-1";
  name="acct_test.out-s390-64"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acct_test.out-s390-64"

s390x s390x s390x GNU/Linux

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

    01 00 03 04  05 06 07 08  09 0a 0b 0c  0d 0e 0f 10
    11 12 13 14  15 16 17 18  19 1a 1b 1c  1d 1e 00 00
    21 22 23 24  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30
    31 32 33 34  35 f0 f1 f2  f3 f4 f5 f6  f7 f8 f9 00

    01 02 03 04  05 06 07 08  09 0a 0b 0c  0d 0e 0f 10
    11 12 13 14  15 16 17 18  19 1a 1b 1c  1d 1e 1f 20
    21 22 23 24  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30
    31 32 33 34  35 36 37 38  39 3a 3b 3c  3d 3e 3f 40

    01 02 03 04  05 06 07 08  09 0a 0b 0c  0d 0e 0f 10
    11 12 13 14  15 16 17 18  19 1a 1b 1c  1d 1e 00 00
    21 22 23 24  1f 20 25 26  27 28 29 2a  2b 2c 2d 2e
    2f 30 31 32  33 34 35 36  37 38 00 00  39 3a 3b 3c


--Boundary-00=_h4MjAamb8QCj9K7
Content-Type: text/plain;
  charset="iso-8859-1";
  name="acct_test.out-s390-emu31"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acct_test.out-s390-emu31"

s390x s390x s390x GNU/Linux

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

    01 00 03 04  05 06 07 08  09 0a 0b 0c  0d 0e 0f 10
    11 12 13 14  15 16 17 18  19 1a 1b 1c  1d 1e 00 00
    21 22 23 24  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30
    31 32 33 34  35 f0 f1 f2  f3 f4 f5 f6  f7 f8 f9 00

    01 02 03 04  05 06 07 08  09 0a 0b 0c  0d 0e 0f 10
    11 12 13 14  15 16 17 18  19 1a 1b 1c  1d 1e 1f 20
    21 22 23 24  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30
    31 32 33 34  35 36 37 38  39 3a 3b 3c  3d 3e 3f 40

    01 02 03 04  05 06 07 08  09 0a 0b 0c  0d 0e 0f 10
    11 12 13 14  15 16 17 18  19 1a 1b 1c  1d 1e 00 00
    21 22 23 24  1f 20 25 26  27 28 29 2a  2b 2c 2d 2e
    2f 30 31 32  33 34 35 36  37 38 00 00  39 3a 3b 3c


--Boundary-00=_h4MjAamb8QCj9K7--
