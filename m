From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/7] bitops: Introduce the for_each_set_port_word macro
Date: Tue, 8 May 2018 07:36:31 +0800
Message-ID: <201805080517.QN2WX3Iy%fengguang.wu@intel.com>
References: <7b704b1feb2f2cdb6c3a3061fa5f5d804954d15d.1525704095.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7b704b1feb2f2cdb6c3a3061fa5f5d804954d15d.1525704095.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, William Breathitt Gray <vilhelm.gray@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi William,

I love your patch! Yet something to improve:

[auto build test ERROR on gpio/for-next]
[also build test ERROR on v4.17-rc4 next-20180507]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/William-Breathitt-Gray/Introduce-the-for_each_set_port_word-macro/20180508-034417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   In file included from arch/openrisc/include/asm/bitops.h:37:0,
                    from include/linux/bitops.h:38,
                    from include/linux/radix-tree.h:24,
                    from kernel/memremap.c:13:
>> include/asm-generic/bitops/find.h:98:1: error: unknown type name 'size_t'
    size_t find_next_port_word(size_t *const word_index,
    ^~~~~~
   include/asm-generic/bitops/find.h:98:28: error: unknown type name 'size_t'
    size_t find_next_port_word(size_t *const word_index,
                               ^~~~~~
   include/asm-generic/bitops/find.h:100:46: error: unknown type name 'size_t'
          const unsigned long *const bits, const size_t size,
                                                 ^~~~~~
   include/asm-generic/bitops/find.h:101:13: error: unknown type name 'size_t'
          const size_t offset, const unsigned int port_size);
                ^~~~~~

vim +/size_t +98 include/asm-generic/bitops/find.h

    82	
    83	/**
    84	 * find_next_port_word - find next port word with set bits in a memory region
    85	 * @word_index: location to store bitmap word index of found port word
    86	 * @word_offset: bits offset of the found port word in respective bitmap word
    87	 * @bits: address to base the search on
    88	 * @size: bitmap size in number of ports
    89	 * @offset: port word index to start searching at
    90	 * @port_size: port word size in bits
    91	 *
    92	 * Returns the port index for the next port word with set bits; the respective
    93	 * bitmap word index is stored at the location pointed by @word_index, and the
    94	 * bits offset of the found port word within the respective bitmap word is
    95	 * stored at the location pointed by @word_offset. If no bits are set, returns
    96	 * @size.
    97	 */
  > 98	size_t find_next_port_word(size_t *const word_index,
    99				   unsigned int *const word_offset,
   100				   const unsigned long *const bits, const size_t size,
   101				   const size_t offset, const unsigned int port_size);
   102	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--BXVAT5kNtrzKuDFl
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICAvC8FoAAy5jb25maWcAjDxJk9s2s/fvV7Ccqlf2wcksHntcr3yAQFBCRBA0QGqZC0vW
0LYqM9J8WpL4379uUJS4NDTvkHiIbmyN3tHQb//5LWCH/eZ5sV8tF09Pv4If5brcLvblY/B9
9VT+bxDqINFZIEKZ/Q7I8Wp9+PePzUu53q52y+DD79effr96v11eB+Nyuy6fAr5Zf1/9OMAQ
q836P7/9h+skksNCpyIx0vIvv+oWnubFAP4VSShZcm5XKj9/mKkVqhiKRBjJC5vKJNZ8fIbX
kNFUyOEoOwMSXUidapMViqXn5swwLgppvkYxG9rC5ini9MfjNlfnVpsxPq669nrgekKR9gEq
jzOJUxUjloSxMGcQNk61wX0AhX4Lho7mT8Gu3B9ezjQbGD0WSaGTwqrGHmQiM6DapGAGppdK
Zl9ub05UNdragmuVylh8ebPZXv/1/gnP7P0bmKhGqsBFJmwWrHbBerPHuRtbYvFEGCt18uXN
G6q5YHmmz0sKRcRgu8VI2yxhCiZ+u96sy3eNOe3cTmTKm9OdYKm2claor7nIBbGeak9KKG3m
BcvgMEYw9al3bkUsB+TALAe2bUIcuYH8we7wbfdrty+fz+Suzx5PJzV6IPpsgSA70lMawkcy
bR9yqBWTDd6uOOHYjBgNHkuZsaLdduJGZDIxEUlmLwKRY1jImc1qzspWz+V2R+02k3wMrCVg
O22xGT0gfyidNGkMjSnMpkPJiQOqeknYWmek1hAgoIURFmZWwES9UwF98Ee22P0V7GHNwWL9
GOz2i/0uWCyXm8N6v1r/6CweFQjjXOdJJpNhc6qBDfEEuQC2AYyM5I2M2TEIdtZfieF5YCmK
JfMCYM2Z4LMQMyANJUe2Qm52t53+clz9QUohbCSPgN9klH25/lC3p0Ym2biwLBJdnNuGiA+N
zlNL7hwlFNgNyEOCLR+J0Am4G4PGmdvIgtinRnCWiZBEMiJmc2Jng3gMXSdOkZmwrdgMUzCw
1bnhAnXPebCwGD7IlBgOIAOA3DSsRljED4q1GmYPHbjufH9omCYO9grYVD6IItIGWR/+USzh
onl4XTQLf1BsMLc8i8+jswT0p0x0KGxTM0xEkcvw+uO5bZBG54+Ky87fHVxnbUATmuYC7VBk
CtjcLYHFMb04pHcFb/V1q77QM6qU2XkJlRavpLvR6ti1sal82NhUHIGyMY1BBgyUYJTHDXpF
eSZmnc8ilc3FilTTu5PDhMVR2MR1C4xojnVqtA2rRxqB/WkOw6Qm0Fg4kbCBI9UaZIDeA2aM
bB8QSBofpxoohJoxA0qQyxrjWHNFiytwCXVKTfNonHX27VkNRBh6RDjl11cfegry6Oql5fb7
Zvu8WC/LQPxdrkFZM1DbHNU1WJ1Kq1fjTFRF28Kp6476b/klLAMrNqaVTsxoM2/jfECdWawH
DQMLveEYzFDU7krzJMBcRDIGO0KM42STGT6q3MeR1oQHCi6as4BFNjKCNbSa0mEeg9mDc3D8
jlqxIR7DjA2gVwzkAX65aWrPyBHLSUPvCIZcT95/W+zAT/+rOo2X7QY89paZRO8XpaWpaJyA
WYXSftVZYpMeVROqNY5mhtHsccTKk0sYR5eRPvLjCGAXT56lh49rzLax7IKRhUCU6MkyIxUs
Fk4iLMZ+gUKHimADiD1kIlwQ4nYMLkjLWzvC8fSP8Eswsu/UyEz4OjeB7d6ON5G/nAcdnuIk
60cx0xrBsVO63SzL3W6zDfa/Xirv63u52B+25a4Rw5nrcXF9c3XVZBRwN0GLVYsD1tf5cETQ
rg7/QP1LMFRJEWaDKjrZrZ7fHB3Ap8VuF0gZyPVuvz0sMYDc9SPIShxlYkEyouvzDil4fBkO
RvMiPJSTlklUlPsBnu91myTQcnN3RfIWgG6vvCAY54qc4QtAzgZVCJVm4GAnoq3BqvaJjkFr
MDOnFXqFRdnzmGWVjWs0FOimoPFqh9GORGjS2owKPv9A6/YoNo0hXE0zx7XgstsvJ0/WqXue
Sd2M/uXQsGPT2f5ZRSy4DjoVLA36geYIQ/Plw9Xnj6f1COB0cJtcqDBumW8eC3DnkHVpS6QY
2f6Qak2rp4dBTmvAB6dsNR35OouRMrBJaFrGHftzPjVhcAu9cOWEMMzTYiASPlLMULrrxNxw
RDYFV9UUoZ01CdJmfztioZ4Ww7RtqU/UCVEjoX/uJDcsvx1+/ADTE2xeOlL7Zw52MU81qszK
YQzBleUi7Z7xaX4BazthoLtYeUk9Cyj+LZeH/eLbU+kyVYFzRfaNqQcyiVSGNrflcLb9Tfwq
QlxkzU5oo0egp1te7HEsy41MW37DEaBg5RShYHQcvCEi4hSbJ+X+n832L5JsIBdj0XZQXAuo
JEa5KHkiW6eJ3z3csx2MaS6aRUY5f5EOG2H6saACOpm01yrTKh7BTATN9il6yhhPgSXS4KLQ
MwJamtABKC5GpvIScIgnK1Q+80SwCRyPHktPFIxjRDqn14VANvLDILz2A2WKis8Pd6egUO+C
TkgsZhX/X8h5kghaN3UwB0JcGNHDYRlPgV7J8HRwrZiqBg4kredOCDx/FWUKkdBUa1qbnrBG
8NcrGPZ1lPkgphX9CWUihszjTdYoyeQyHGMzdPIvY8WvrBXCJ30ZYy48PHnCkDHobS1f2U/I
XyUcDz2a5cQIA0MwUa1jDeylnz2uO395sy3XmzftUVV453P9ZTr56JNhTLMXVvCuXezhpKO5
Sw2AjVWpzw4DMkSJF9RVyD2UA5jlGQ0zoedAfPlycNTI9vjGM8PAyHBI5aacsXdSb1lToI9N
5GCTmCXF/dXN9VcSHAqeePRLHPMbz4ZYTB/P7OaOHoqldC4gHWnf9FIIgeu+++A73Cr3SW+L
0/MN4DAY+p60EkC3ZmKnMuO0aE4sZu89Xh2sCOR17DfkKvVYctxLYukpR9Zv36uVhoLeDGLE
txAKWBCB4hJWwq2kLgoAZGbg1Nl5gSm7hoP1Ne74RcG+3B2z/q2h03E2FAm9M6YMCyWtJjmj
Ow1oZmERrNT4BDAqxpyWwak0IvYlIKZSMdodMdFYehIfuOnPtFxzJiMaINJR4bsVSyLPNZwF
1ecxU85xiWhYPL3gezhNIibIxwRDKDZ3WYkjRs0CYfn3alkG4Xb1d5VIPF+TrpbH5kB3nea8
SjGORJw2b1tbzeBHZ6PGpSZMnKk0sk1rVLWArwRxdOsSOAlZ3I+63eiRNGrKwOPEBAetQaKp
S6QJyjBihDh1lyKNkKGhUjEMCo2ceCzPEUFMjMebrRDwvvc4DJhgpScelwTRGDjIvEZ216HE
sk93kBCcwuySi1NGaXDYBY/uGFuJYPgnETzT9D5URuXew6xRNqCjVtQYYaiTeS6yAYpJjMwI
0RygEMzEcxo01oM/Ww2YVABxbrW1km/wXYU/528FOqizSqC16dyGNUI703XyK0U4USKwh5eX
zXZfy4DCqguCrsAyao4LI2cQCY+1zYE9Ibhzx0THRIbRSo3fkAsUAhhDBbvTEs8TOkjx+ZbP
Pva6ZeW/i90xy/fsrg12Pxfb8jHYbxfrHQ4VPK3WZfAIe1294J/NoTNZ2P5S2NO+3C6CKB2y
4Ptq+/wPDBg8bv5ZP20Wj8Hz5vHwVAZvt+V/D6ttCZPf8Hc1SeV6Xz4FCsKS/wm25ZOrfdm1
qX5GQbau9E8Nsxx0cL95olOi9TzQaLPbe4F8sX2kpvHib15OCVy7hx0EarFe/CiRusFbrq16
11WmuL7TcOdz4yPdo61FY17xXIMwNc8AEMPKVorjrAtqwZayhVDf+p2tsE5Cn9fteJvm6685
i+XDhYRFJjwsrRhHR5Z2ymY+CPSCYMI3G/xltS/Oy+kRob2YOIq4KhdP74nIaGcuiZVOeifm
/IKzND22jz5cgeStvh2Q0e0/q/3yZ8C2y5+rfbnEjH8DvSZzNhKmpeRwwWD3Qm3AdDGOyf92
UQ7DKIkVmaXMRrO3Yg/N/G8TBIebZJLRQMO78UoNyY02zDMrB/vbucWHI6UuDxsjVlU1upU/
Hnygg4gBV2gUaZ/SzsFxVl1V2p8QhCOTSSsgGwolE3k6CVpOOoD+wOLhWKN0liDXUiQp+Dss
YTANejPdHfRHGuVsKiR5NDLJRExD7m/uZjMSBPH5RLQrENREheQle7Ob5Ea0eo3t/f3ddaHI
eoBGz4QBbyp6B/Cn0YlWgobSne5vP181Es3ZSHMSD1UWFlg1F/0VGgoBnEjHBurV4zBwYpZZ
ckKDEaYhQeDw27xdO2Vnw4EoOuqG6CnEV3pIHTMDrpWhiQfhrgQXekbrEpvhgbZ8J2gCury+
oIlsyQt8FmYkE486BSiwG6wlo/LZjWGn8qGT3K5aiundteci74RwS97mNbc7T3QKSqHl6095
MYuHHV6oRQIE4uhoN2wrNkJI3ZId18bxtlv62KrCkdmAeexuPXCh8lkxTD1xdQtLKQmG/cJw
IwnuQtRl9doRHs0hZm2EXFNoqQMKcCEC+KwdkbOROtscFeIQdMR+NCZ+hOz+6nbmBQMtP81m
F+H3ny7BjzbEi8Al2Cb/8o4mwQsPGTDFheHD9P72/ubmMvzD/WX4x09deB3ayplwtG/dAvE0
BrbwjejMRDGbsrkXJbZo8a6vrq+5H2eWeWFHo/Iq/Ppq6NlYZV+6O3NKytlN78iIgfbFi5G4
W27mX9zXi92NQA9rfAHuDIIfDkbh4g6ssn6igxtzfTXz3BGA3wc6TnL/5BNwF60VXvgMK7FA
5YDI3xj8Px02p57a1Lh9LehUBIZb73erxzLI7aCOYhxWWT7iYweInBBSJx/Z4+IFIkoqtp12
goMqFF67m+jpChN8b/tXu++C/Qawy2D/s8YiNNjUE3ZIG/anlOuXw74flzUELM37gfIIQksX
HMs/dIBdWguwWORNLmHIlCCTABxi98USaXVOS9SskLXEZkI5MXhT/Rn0TtY2g7EYMj53zfQh
w0JBeBKIuFxeztA5t6QYWjr+Oz7noNOSYGI75Z7QMoamfmxcbleLp37IdFyfyzTxZoBzBIAn
fEU2NoqqXXUxbLDlDjUwI1Sh1PKbSMeYlJ4rMUXOTNaoyWlCDVbWK3FCIRcBrhw4M55LkyYi
symW40xwtFeRw+mrKCa7ub+f+XevoyKNWYaF26ebhc36PfYFbHdqTgcQknMcAVcag6ryz9Gu
JWk0NsjeHdVynnhU5xHjGDv/mbHha8Q6or6GdlSoEOS9OqChncUjOLJxEaevDcLRwwd3qwjl
ELyS2JPtPWJj1hv8R1pKs/mxgpzWiymYyOPzKhJhNC3AGoWa1gHm9vPHfnVzyhWXLFgSeu28
Lg7/pfSoQOx43tlQpbBvOKmnbzwkT2m7Z2HT9Gatz1D215JmabB82iz/olYEwOL67v6+elvk
s3WVt+5qRb2X6A2jt3h8XKEpBLlzE+9+b00pE54ZKmbHwKMVFYBgY1v/gsQboiCgeunQ24sq
nzfbX8Hz4uUFvAA3AmGX3QCfPsyqAMc/RyWOfng49V1bO3CU4T9X13Rc6VDqG5datV3ANJfp
MYqntNJ2UDW4/2g/0XeVFQJwhudxkINXKqdP7yisqFz++wKc0/V/rmkG1lNhCjahdUQFNcJ6
0mIVHN9nxrS7OZp2cqhnMR8Joxh9sTlleFOuqVopawf4GsbKQccCWCrTCKEjI9EHnSrUioCH
p/3q+2HtyqMvBMNAaKwTgeAlisWMezTgGWsU89CTJwCckfz44ea6SPGygSRhBizJrOS33iHG
QqWem1EEq+zj7edPXrBVd1c0c7DB7O7qylldf++55Z4jRnAmC6Zub+9mRWYhCvdk4cQwB6Hz
3VyKULL6EXDv0IbbxcvP1XJHKdvQ9L1KxtPgLTs8rjYB35xq89/1HldXyCoM4tW37QL02HZz
2K/W5SnVH20Xz2Xw7fD9O9ixsG/HIl9RCx/H+KC6AK6gdnVmaZ0n1J0txFKFHnFZgAOVxaL3
yhvhvSfT2OgeKowgch3xVolh3pYdtwlsoy44sD39+WuHT9qDePELbXhfQhKduhlnXEi6kgWh
TplNfP6Jw2Dh0KN6snnquS3CjnmcSq/nk0/po1HKI6VCWXwWS4dBYgoRlafMjHF8KCsHoLAz
X6oGQg05YInnnWeGr5CZp+YlVOx4Hdg7PwAN8qhR/XxmKyw+iKTnNozls1Da1HefnnvM3kSa
uvyBqmpHMBo2keTtTHLV3DH8x9v45Xaz23zfB6NfL+X2/ST4cSh3dEwB3rzvgnM0rV/s9KNr
56PZzWHrUfNMxgNNhUFSK5U3ZKxVQuOAQbr4UVYV9J0qAwNe0b7EO2VqTiwdyfCCn/eWa16e
dz/IPqmyNS39igSLp/ohNszz1rrH2IFeB/zn6uVdsHspl6vvp2Kgk+iz56fND2i2G97VCoPt
ZvG43DxTsNXvaka1fz0snqBLt09j1RysR2/JM3yI96+v0zEam3C6ujxVGBJFRnhqOWaZ15a5
n0igRdhD9nTatz5YRbIEKvcv+wHS/pEDZlQBIR6w4axIzJfr1lOxVLbuaCU+YfDqO+e/YeSY
GR37wrlI9VkOk4jN1/pnN7R2lf0p+2KsE4a62J8Yx5AmnbHi5j5RGGF5SueaWDieF0ux1JWo
FipUHz96rpCcy8oZ7V4rTyWqYX0Ny9aP283qsXVLkoRGS0+Rq6c6ESuR+nwymmKNwRKznKTC
o13OKu/vKWdw9TskwBPbWqk97ztiqaggPMK3QhWzNCscZqglo1aqrW6rHoQWOqWMBtoo9xsw
1U9QnLRyEqKrOO/CG/vBoiwzdxk+alyb6ExGrfxpWDVRur6CFN0fAIhYv8sJ+DXXGU1s/O2H
yH4oIlpUI6zY9MCOdW4FEWrzxfJnx/u0vRd4lUjvysPjxj3r6p0Ump2ifVCuadwNAJrA7k8w
uEb37A4iPwkH1RsO1FwcGkEdzViYpFkw6hIL58+6nPTsBLpq0urXERing8kKZ4YFiSS8+gdQ
IooJ8fWZ47SqwKQ1uzYsGYpez/PI7hc3aC3U+0WCkztZpXvaU9ZAN1f7e3LT+b5tFe+4Fi9t
HNhTso+/XTH16EkAUpHJ0CX+q1+zOa/K/YxT5xNmbS/79Ls49cnniUlbNq5qqfJRNLmxMNt3
FNIH0CHzdWL+o03ivhDacnnYrva/KKd7LLyXLTw3EByALy+sM9UZGFZfCrjCvQj0LBjft4LB
Ri2GD9Wqim3iCOsHQ+d1sUatTRfaqPZ2ClfXzjDf/nrZb4LlZlsGm23ws3x6cdWQLeSCxcP/
a+xqlhu3YfB9nyLHdqbdiZ3sNj30QMlypESWFEmO4lw0qeNJPFs7mdiZ9vELgNQfBdB7yi4B
UyQIASQIfFJZL+Vn0DwdtyP4w45pHLN68a0fZWGQj0lwAA5HvWDjmDUHx2JzQhvL2CJfjAYo
juQ2y5hJYgXjdFBPbZ4h1AwZ8oz3+oYa+DMuycdQdXpaPhq6aedGY5eysj+s4ShJEByYRF4w
vVzPJ9OrxZKLTRuOBPFq7HFh41hyaDcJgoF5EP3hN2bNkE+zgO8OYWfhYrGz5fVO8fP4utkj
CiCmhQb7Nb4cGGL8d3t8PVOHw9t6S6TZ0/FpkNFvBi/UwzRCdJP9EDYCanqepfFqcnHO13wZ
3iK4G8ZrbC0KVZRE97Ag+thHJ+jd27NViGAe7DlF5QsBsoYsueuGLPlcM1Jn53HOX4IacnZi
6A/uh4Oxr3LFJEo8HV5lafF5W419AipIfTSQEwO9tzo1Ocovm8ORG0LuXwgXZn2OEwzl5Hwm
lU4ZhUVr65T/T6jqYsbvW1qy+9cRqDKclaSge2NzFzMwUKc4vvMnzY5j+o0vou04LqbOPopQ
TWTlACo8gVEPIHybONcLOPhrhYa+cJLL63zyp/MBVWaNQOvd9v11kNPROnPOSyhCNnRa5mTp
CaXXDUfuO/UFDqLVPHKrpa8WQRxHTjeMuAxOzUMGpzbMhAoiQ57TX6f5CdWjABnVrKqKC+XW
uMZruL2FkJvS0vMsSJxjLRbOVSmyQAi7t/7WuRpwlrIXVevf2+79Y3M46Kue8Qpg/ZqAXmMc
yKNQCavJV5fOlyJ+dM4ayCET/33aP7/tzpLP3d+bD4Nre+QnoJIiqv0sZyHXmknm3rUOyNu7
K6KQwxm/ippmme8xy6jPGywkhDN/mafZirFUuJ2sYdM/6ltkLMy2+qeYc+F2wObDw4TDCVec
RLCw1M+DcajF33wcMY4OW7sDJUEeti97Av46W79u1j90ATaxMneM5ileVGIZbF4wkLlwVEz8
bFXPsR7QxKcYljhIBCrmyy/LKGagbzM/wmuOPjJVi8drmnuS8EEEsMKCjP2JZPD82rlbgGeV
y5pLbaSNiDWGiylYnHguFKwahjjyA291xfxUU6QXk1hUXsl2ATm8SJSB2DF/MR9HnnM75vO7
Ep2R5ZYE2C5EkjBofr3AzOMl2/7wiM32/+uHq++jNgquZ2PeSH2/HDWqfMG1leFy4Y0IiOE8
7tfzb/oraVqFeXdzs0Fte5QhuG2P0Ae5HfCnQntvwnjnDm9NH7sNm2b9RxXXMZWq96Mtd/1a
LyqpHr+NqkxhE0vi7QW1cgtNugt0zwSAFUTm5pFeQRXns0GdDsaoEHyH0bEvPRDT16eBkXv/
2O6PPyip7Xm3ObxwcTKDwIyJbtw7rDM/EZuZQD3bmMsfbbgWZI+x5xHHZef4t/9sficgbLLC
BxrQWrd/cGPSGXBRMuddfpBQiKNSeXIKtdmwLpZFOUZeMzzzHHaZ1Ntfk/Pp5VDoWa2KRS3C
ayIGJj1BCZnZBqATOvBSAd6EQvdplTjhENhQuUF20zMbpxAWAeERYkR9oSzMlmaKFosWaprE
q/61KLUjLgRJiiB+B4Byg/bxODTuahWo2wa/kJ3oQuHla7EqhnX/g67wuiJowVVMvmOL2DfQ
a5Qq5XMXkXDDrLtERhnTkLqBmRVpIlZ0UzepdxNIIRKzHPjhBdgXqGveoWmue16PNNF8NgCx
xTl1QPyj3rPw+moepxWjGX2ya8ihBcLwpUVIPIvf1j8+3/XLHD7tX6xUgjmBZC4RirCUMTI0
sQ6XicawZ5mqOzY/sbdGCSgOaHHKX2sO6PW9ipdBBxesiWj+0mXZNWvceJLCwA5js4xcqX+l
FzpIZmOTY8kXH3sbBDZEl96hYqSvA6P85fC+3VOq8W9nu8/j5r8N/GNzXH/9+vXXbvNKl7vU
9zX5izZhpmfvYd2bS1x+I4R94BwdA+/AmF3aw+QB2Qp9spOq0kwIgF0h3o2Dl0Yuv8uaSbtv
6A7kfqIvFCGdfIzb5cdJTwUFLxGSxPbOnRK382B8eM/lNB9n4TtB6wwTBLeCoQAEnJQLAozF
1IbJNdNIGIyxj9EpjsJlF+nOPpJA0jUPHOZmARa0Mnd8+P0K1sDj1yrwWwayyJHj5LoQkyhw
+iTGXeG4AzVaeme8XC77t0YSdZDnhCxwo50vy6xv/dw8GDJJ/FWZckjOOKehCWh6ptkOcpny
O7DXcy0GobqFDJuDIawQYNnBYHZiLTwicUrI5kiri0Rl+EEXZnIeqD1sSjTOfcCgR+t2lYDM
qfhM/0AwNC07vFhORhqY/sKBC5+4Eb35jo2p72g0ytShoUIik52hSXhV+MKBDxXSlIlFpHrd
550Q/VdWfA/xomQ6bebAWdZuNoPmLNKb05Lb7tGUwuABwcIcc9anIH2VLiwR8t0CYymkUhED
HXr4GAjRvahcCIkYRF8uhZwzouYYUitlkFSaqxR10+t/K9R50sMxduanGZ+VoMef8ZObR7Ap
gcnx6msJm9KMHMOY2V/EsReL8h/EPAzYy4rqQBtqONypUuHROl+OMss6y0Qwf0LauVcMa5D/
BwGB6UoibgAA

--BXVAT5kNtrzKuDFl--
