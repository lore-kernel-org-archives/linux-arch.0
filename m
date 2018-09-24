From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [REVIEW][PATCH 1/2] signal/arc: Push siginfo generation into
 unhandled_exception
Date: Mon, 24 Sep 2018 17:37:20 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B096A87@us01wembx1.internal.synopsys.com>
References: <874lef2bqn.fsf@xmission.com>
 <20180924144910.14902-1-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Vineet Gupta <vineet.gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

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
