Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:38314 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbeIXXkh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 19:40:37 -0400
From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [REVIEW][PATCH 1/2] signal/arc: Push siginfo generation into
 unhandled_exception
Date: Mon, 24 Sep 2018 17:37:20 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B096A87@us01wembx1.internal.synopsys.com>
References: <874lef2bqn.fsf@xmission.com>
 <20180924144910.14902-1-ebiederm@xmission.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Vineet Gupta <vineet.gupta1@synopsys.com>
Message-ID: <20180924173720.4TT0EjbdfPApL_JA-Rz7aq8iF5pBb2ODNnp9sGyxBQE@z>

On 09/24/2018 07:49 AM, Eric W. Biederman wrote:=0A=
> Pass signr, sicode, and address into unhandled_exception as explicit=0A=
> parameters instead of members of struct siginfo.  Then in unhandled=0A=
> exception generate and send the siginfo using force_sig_fault.=0A=
>=0A=
> This keeps the code simpler and less error prone.=0A=
>=0A=
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>=0A=
=0A=
LGTM.=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
Thx,=0A=
-Vineet=0A=
