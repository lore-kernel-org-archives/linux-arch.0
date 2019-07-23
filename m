Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37290 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbfGWDIp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jul 2019 23:08:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so30070389qkl.4
        for <linux-arch@vger.kernel.org>; Mon, 22 Jul 2019 20:08:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
From: Qian Cai <cai@lca.pw>
In-Reply-To: <CAA2zVHqXDuMzBC6dD5AbepZc63nPdJ3WLYmjinjq01erqH+HXA@mail.gmail.com>
Date: Mon, 22 Jul 2019 23:08:41 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <BE0991D9-65E7-43CA-A4B4-D3547D96291A@lca.pw>
References: <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
 <CAGG=3QUvdwJs1wW1w+5Mord-qFLa=_WkjTsiZuwGfcjkoEJGNQ@mail.gmail.com>
 <75B428FC-734C-4B15-B1A7-A3FC5F9F2FE5@lca.pw>
 <20190718.162928.124906203979938369.davem@davemloft.net>
 <1563572871.11067.2.camel@lca.pw> <1563829996.11067.4.camel@lca.pw>
 <CAA2zVHqXDuMzBC6dD5AbepZc63nPdJ3WLYmjinjq01erqH+HXA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Y Knight <jyknight@google.com>
Cc: David Miller <davem@davemloft.net>, Bill Wendling <morbo@google.com>, Nick Desaulniers <ndesaulniers@google.com>, sathya.perla@broadcom.com, ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, netdev@vger.kernel.org, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, natechancellor@gmail.com, Jakub Jelinek <jakub@redhat.com>
Message-ID: <20190723030841.jPyYcPrOhD41sCVzUPUTDoS3d4qd_2t6fkVBZwYOuYM@z>

The original issue,

=
https://lore.kernel.org/netdev/1562959401-19815-1-git-send-email-cai@lca.p=
w/

The debugging so far seems point to that the compilers get confused by =
the
module sections. During module_param(), it stores =
=E2=80=9C__param_rx_frag_size"
as a =E2=80=9Cstruct kernel_param=E2=80=9D into the __param section. =
Later, load_module()
obtains all =E2=80=9Ckernel_param=E2=80=9D from the __param section and =
compare against the
user-input module parameters from the command-line.  If there is a =
match, it
calls params[i].ops->set(&params[I]) to replace the value.  If compilers =
can=E2=80=99t
see that params[i].ops->set(&params[I]) could potentially change the =
value
of rx_frag_size, it will wrongly optimize it as a constant.


For example (it is not
compilable yet as I have not able to extract variable from the __param =
section
like find_module_sections()),

#include <stdio.h>
#include <string.h>

#define __module_param_call(name, ops, arg) \
        static struct kernel_param __param_##name \
         __attribute__ ((unused,__section__ =
("__param"),aligned(sizeof(void *)))) =3D { \
                #name, ops, { arg } }

struct kernel_param {
        const char *name;
        const struct kernel_param_ops *ops;
        union {
                int *arg;
        };
};

struct kernel_param_ops {
        int (*set)(const struct kernel_param *kp);
};

#define STANDARD_PARAM_DEF(name) \
        int param_set_##name(const struct kernel_param *kp) \
        { \
                *kp->arg =3D 2; \
        } \
        const struct kernel_param_ops param_ops_##name =3D { \
                .set =3D param_set_##name, \
        };

STANDARD_PARAM_DEF(ushort);
static int rx =3D 1;
__module_param_call(rx_frag_siz, &param_ops_ushort, &rx_frag_size);

int main(int argc, char *argv[])
{
        const struct kernel_param *params =3D <<< Get all kernel_param =
from the __param section >>>;
        int i;

        if (__builtin_constant_p(rx_frag_size))
                printf("rx_frag_size is a const.\n");

        for (i =3D 0; i < num_param; i++) {
                if (!strcmp(params[I].name, argv[1])) {
                        params[i].ops->set(&params[i]);
                        break;
                }
        }

        printf("rx_frag_size =3D %d\n", rx_frag_size);

        return 0;
}
