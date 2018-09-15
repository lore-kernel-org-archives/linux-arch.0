From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
Date: Sat, 15 Sep 2018 22:01:04 +0200
Message-ID: <CAHmME9o5zaJOHGrYtS8kof-PDKbUYNfU8t=b-oEZg02evML0qw@mail.gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com>
 <20180912061433.GA8484@ip-172-31-15-78> <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
 <20180913050301.GA26367@ip-172-31-15-78> <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
 <61B4DFD6-9BB5-4B81-BD0E-ACF112EA8AF7@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61B4DFD6-9BB5-4B81-BD0E-ACF112EA8AF7@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: kevin@guarana.org, Andrew Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Sep 15, 2018 at 9:58 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> I have no strong opinion, except that, if you paint the bikeshed =E2=80=
=9Cpass by value=E2=80=9D, then simd_get and simd_relax should probably hav=
e warn_unused_result set.

Good idea.
